import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/service_store.dart';
import '../../stores/auth_store.dart';

class ServiceFormScreen extends StatefulWidget {
  final ServiceData? service;

  const ServiceFormScreen({super.key, this.service});

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final _serviceStore = getIt<ServiceStore>();
  final _authStore = getIt<AuthStore>();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _finalPriceController;
  late TextEditingController _materialCostController;
  late TextEditingController _durationValueController;
  late TextEditingController _descriptionController;

  File? _selectedImage;
  String? _existingPhotoPath;
  String _durationUnit = 'days';
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.service != null;
    _nameController = TextEditingController(text: widget.service?.serviceName ?? '');
    _finalPriceController = TextEditingController(text: widget.service?.finalPrice.toString() ?? '');
    _materialCostController = TextEditingController(text: widget.service?.materialCost.toString() ?? '0');
    _durationValueController = TextEditingController(text: widget.service?.durationValue.toString() ?? '1');
    _descriptionController = TextEditingController(text: widget.service?.description ?? '');
    _durationUnit = widget.service?.durationUnit ?? 'days';
    _existingPhotoPath = widget.service?.photoPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _finalPriceController.dispose();
    _materialCostController.dispose();
    _durationValueController.dispose();
    _descriptionController.dispose();
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
              const Text('Pilih Sumber Foto Jasa / Layanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                  title: const Text('Hapus Foto Jasa', style: TextStyle(color: AppColors.error)),
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

    final price = int.tryParse(_finalPriceController.text) ?? 0;
    final cost = int.tryParse(_materialCostController.text) ?? 0;
    final duration = int.tryParse(_durationValueController.text) ?? 1;

    bool success = false;
    if (_isEditing) {
      success = await _serviceStore.updateService(
        id: widget.service!.id,
        serviceName: _nameController.text.trim(),
        finalPrice: price,
        materialCost: cost,
        durationValue: duration,
        durationUnit: _durationUnit,
        description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
        newImageFile: _selectedImage,
        existingPhotoPath: _existingPhotoPath,
      );
    } else {
      success = await _serviceStore.createService(
        serviceName: _nameController.text.trim(),
        finalPrice: price,
        materialCost: cost,
        durationValue: duration,
        durationUnit: _durationUnit,
        description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
        imageFile: _selectedImage,
      );
    }

    if (!mounted) return;

    if (success) {
      AppNotification.showSuccess(
        context,
        _isEditing ? 'Jasa berhasil diperbarui' : 'Jasa baru berhasil ditambahkan',
      );
      Navigator.of(context).pop();
    } else {
      AppNotification.showError(
        context,
        _serviceStore.errorMessage ?? 'Gagal menyimpan jasa',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Jasa' : 'Tambah Jasa'),
        actions: [
          if (_isEditing && _authStore.isOwner)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () {
                ConfirmationDialog.show(
                  context,
                  title: 'Hapus Layanan?',
                  message: 'Layanan ${widget.service!.serviceName} akan dihapus dari katalog.',
                  isDanger: true,
                  onConfirm: () async {
                    final nav = Navigator.of(context);
                    await _serviceStore.deleteService(widget.service!.id);
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
                      _selectedImage != null || _existingPhotoPath != null ? 'Ganti Foto' : 'Unggah Foto Jasa',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                AppTextField(
                  label: 'Nama Jasa / Layanan *',
                  hint: 'Contoh: Cuci Sepatu Deep Clean / Potong Rambut',
                  controller: _nameController,
                  validator: (v) => FormValidators.required(v, 'Nama jasa wajib diisi'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Tarif Jasa (Rp) *',
                        hint: '0',
                        controller: _finalPriceController,
                        keyboardType: TextInputType.number,
                        validator: (v) => FormValidators.positiveNumber(v, 'Tarif jasa'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppTextField(
                        label: 'Modal Bahan (Rp)',
                        hint: '0',
                        controller: _materialCostController,
                        keyboardType: TextInputType.number,
                        validator: (v) => FormValidators.positiveNumber(v, 'Modal bahan'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Durasi Pengerjaan',
                        hint: '1',
                        controller: _durationValueController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Satuan Waktu',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _durationUnit,
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(value: 'minutes', child: Text('Menit', style: TextStyle(fontSize: 13))),
                                  DropdownMenuItem(value: 'hours', child: Text('Jam', style: TextStyle(fontSize: 13))),
                                  DropdownMenuItem(value: 'days', child: Text('Hari', style: TextStyle(fontSize: 13))),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _durationUnit = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Keterangan Layanan',
                  hint: 'Contoh: Termasuk pembersihan tali dan sol',
                  controller: _descriptionController,
                  maxLines: 2,
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
        Icon(Icons.build_circle_outlined, size: 28, color: Color(0xFF64748B)),
        SizedBox(height: 4),
        Text('Pilih Foto', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
      ],
    );
  }
}
