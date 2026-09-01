import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/product_store.dart';

import '../../stores/auth_store.dart';

class ProductFormScreen extends StatefulWidget {
  final ProductData? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _productStore = getIt<ProductStore>();
  final _authStore = getIt<AuthStore>();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _skuController;
  late TextEditingController _costPriceController;
  late TextEditingController _sellingPriceController;
  late TextEditingController _stockController;
  late TextEditingController _minStockController;
  late TextEditingController _unitController;

  File? _selectedImage;
  String? _existingPhotoPath;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.product != null;
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _skuController = TextEditingController(text: widget.product?.sku ?? '');
    _costPriceController = TextEditingController(text: widget.product?.costPrice.toString() ?? '');
    _sellingPriceController = TextEditingController(text: widget.product?.sellingPrice.toString() ?? '');
    _stockController = TextEditingController(text: widget.product?.stock.toString() ?? '0');
    _minStockController = TextEditingController(text: widget.product?.minStockAlert.toString() ?? '5');
    _unitController = TextEditingController(text: widget.product?.unit ?? 'pcs');
    _existingPhotoPath = widget.product?.photoPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 85, maxWidth: 800);
      if (picked != null) {
        setState(() {
          _selectedImage = File(picked.path);
        });
      }
    } catch (e) {
      if (mounted) {
        AppNotification.showError(context, 'Gagal memilih foto: $e');
      }
    }
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pilih Sumber Foto Produk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: Color(0xFF1E3A8A)),
                title: const Text('Ambil dari Kamera'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: Color(0xFF1E3A8A)),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_selectedImage != null || _existingPhotoPath != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
                  title: const Text('Hapus Foto Produk', style: TextStyle(color: AppColors.error)),
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() {
                      _selectedImage = null;
                      _existingPhotoPath = null;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final cost = int.tryParse(_costPriceController.text) ?? 0;
    final sell = int.tryParse(_sellingPriceController.text) ?? 0;
    final stock = int.tryParse(_stockController.text) ?? 0;
    final minStock = int.tryParse(_minStockController.text) ?? 5;

    bool success = false;
    if (_isEditing) {
      success = await _productStore.updateProduct(
        id: widget.product!.id,
        name: _nameController.text.trim(),
        sku: _skuController.text.trim().isEmpty ? null : _skuController.text.trim(),
        costPrice: cost,
        sellingPrice: sell,
        stock: stock,
        minStockAlert: minStock,
        unit: _unitController.text.trim(),
        newImageFile: _selectedImage,
        existingPhotoPath: _existingPhotoPath,
      );
    } else {
      success = await _productStore.createProduct(
        name: _nameController.text.trim(),
        sku: _skuController.text.trim().isEmpty ? null : _skuController.text.trim(),
        costPrice: cost,
        sellingPrice: sell,
        initialStock: stock,
        minStockAlert: minStock,
        unit: _unitController.text.trim(),
        imageFile: _selectedImage,
      );
    }

    if (!mounted) return;

    if (success) {
      AppNotification.showSuccess(
        context,
        _isEditing ? 'Barang berhasil diperbarui' : 'Barang baru berhasil ditambahkan',
      );
      Navigator.of(context).pop();
    } else {
      AppNotification.showError(
        context,
        _productStore.errorMessage ?? 'Gagal menyimpan barang',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Barang' : 'Tambah Barang'),
        actions: [
          if (_isEditing && _authStore.isOwner)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () {
                ConfirmationDialog.show(
                  context,
                  title: 'Hapus Barang?',
                  message: 'Barang ${widget.product!.name} akan dihapus dari katalog.',
                  isDanger: true,
                  onConfirm: () async {
                    final nav = Navigator.of(context);
                    await _productStore.deleteProduct(widget.product!.id);
                    nav.pop();
                  },
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Photo Picker Header
                Center(
                  child: InkWell(
                    onTap: _showImagePickerModal,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1), width: 1.5),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: _buildPhotoWidget(),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: TextButton.icon(
                    onPressed: _showImagePickerModal,
                    icon: const Icon(Icons.add_a_photo_outlined, size: 16),
                    label: Text(
                      _selectedImage != null || _existingPhotoPath != null ? 'Ganti Foto' : 'Unggah Foto Barang',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                AppTextField(
                  label: 'Nama Barang *',
                  hint: 'Contoh: Sepatu Sneaker / Botol Sabun',
                  controller: _nameController,
                  validator: (v) => FormValidators.required(v, 'Nama barang wajib diisi'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppTextField(
                        label: 'SKU / Barcode',
                        hint: 'Opsional',
                        controller: _skuController,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppTextField(
                        label: 'Satuan',
                        hint: 'pcs/box',
                        controller: _unitController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Harga Modal (Rp)',
                        hint: '0',
                        controller: _costPriceController,
                        keyboardType: TextInputType.number,
                        validator: (v) => FormValidators.positiveNumber(v, 'Harga modal'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppTextField(
                        label: 'Harga Jual (Rp) *',
                        hint: '0',
                        controller: _sellingPriceController,
                        keyboardType: TextInputType.number,
                        validator: (v) => FormValidators.positiveNumber(v, 'Harga jual'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Jumlah Stok',
                        hint: '0',
                        controller: _stockController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppTextField(
                        label: 'Batas Minimum',
                        hint: '5',
                        controller: _minStockController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: AppStrings.save,
                  width: double.infinity,
                  height: 42,
                  onPressed: _handleSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoWidget() {
    if (_selectedImage != null) {
      return Image.file(_selectedImage!, fit: BoxFit.cover);
    }
    if (_existingPhotoPath != null && _existingPhotoPath!.isNotEmpty) {
      final file = FileStorageService.resolveFile(_existingPhotoPath) ?? File(_existingPhotoPath!);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover);
      }
    }
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.camera_alt_outlined, size: 28, color: Color(0xFF64748B)),
        SizedBox(height: 4),
        Text('Pilih Foto', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
      ],
    );
  }
}
