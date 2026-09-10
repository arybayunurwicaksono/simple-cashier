import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:ui/ui.dart';
import '../../../di/injection.dart';
import '../../../stores/store_store.dart';
import 'forgot_pin_dialog.dart';

class StorePinSheet extends StatefulWidget {
  final StoreData store;
  final bool allowSwitchStore;

  const StorePinSheet({
    super.key,
    required this.store,
    this.allowSwitchStore = false,
  });

  static Future<bool?> show(
    BuildContext context, {
    required StoreData store,
    bool allowSwitchStore = false,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StorePinSheet(
        store: store,
        allowSwitchStore: allowSwitchStore,
      ),
    );
  }

  @override
  State<StorePinSheet> createState() => _StorePinSheetState();
}

class _StorePinSheetState extends State<StorePinSheet> {
  String _enteredPin = '';
  bool _isVerifying = false;
  String? _errorMessage;
  late bool _rememberThisStore;

  final _storeStore = getIt<StoreStore>();

  @override
  void initState() {
    super.initState();
    _rememberThisStore = _storeStore.defaultStoreId == widget.store.id;
  }

  void _onDigitPressed(String digit) {
    if (_isVerifying || _enteredPin.length >= 6) return;

    HapticFeedback.lightImpact();
    setState(() {
      _errorMessage = null;
      _enteredPin += digit;
    });

    if (_enteredPin.length == 6) {
      _verifyPin();
    }
  }

  void _onBackspacePressed() {
    if (_isVerifying || _enteredPin.isEmpty) return;

    HapticFeedback.lightImpact();
    setState(() {
      _errorMessage = null;
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    });
  }

  Future<void> _verifyPin() async {
    setState(() => _isVerifying = true);
    final success = await _storeStore.verifyStorePin(
      storeId: widget.store.id,
      pin: _enteredPin,
      rememberThisStore: _rememberThisStore,
    );

    if (!mounted) return;

    if (success) {
      HapticFeedback.mediumImpact();
      Navigator.of(context).pop(true);
    } else {
      HapticFeedback.heavyImpact();
      setState(() {
        _isVerifying = false;
        _enteredPin = '';
        _errorMessage = _storeStore.errorMessage ?? 'PIN salah. Silakan coba lagi.';
      });
    }
  }

  Future<void> _handleForgotPin() async {
    final resetSuccess = await ForgotPinDialog.show(context, widget.store);
    if (resetSuccess == true && mounted) {
      setState(() {
        _enteredPin = '';
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Store Info Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  _buildStoreAvatar(),
                  const SizedBox(height: 10),
                  Text(
                    widget.store.storeName,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary(context),
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Masukkan 6-Digit PIN Toko',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 6 PIN Dots
            _buildPinDots(),

            // Error message
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            const SizedBox(height: 8),

            // Remember This Shop Checkbox
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                onTap: () => setState(() => _rememberThisStore = !_rememberThisStore),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _rememberThisStore,
                          activeColor: AppColors.primaryAccent(context),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) => setState(() => _rememberThisStore = val ?? false),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Ingat toko ini di perangkat ini',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary(context),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Numpad Grid (0-9, Backspace, Switch)
            _buildNumpad(),

            const SizedBox(height: 12),

            // Footer Actions: Forgot PIN & Switch Store
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _handleForgotPin,
                  child: Text(
                    'Lupa PIN?',
                    style: TextStyle(
                      color: AppColors.primaryAccent(context),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (widget.allowSwitchStore) ...[
                  Text(
                    ' • ',
                    style: TextStyle(color: AppColors.textSecondary(context)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop('switch_store'),
                    child: Text(
                      'Beralih ke Toko Lain',
                      style: TextStyle(
                        color: AppColors.textSecondary(context),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreAvatar() {
    final initials = widget.store.storeName.isNotEmpty
        ? widget.store.storeName.trim().substring(0, 1).toUpperCase()
        : 'T';

    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.primaryAccent(context),
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent(context).withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        final isFilled = index < _enteredPin.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          width: isFilled ? 14 : 12,
          height: isFilled ? 14 : 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled
                ? AppColors.primaryAccent(context)
                : (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white24
                    : Colors.grey.shade300),
            border: isFilled
                ? null
                : Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white38
                        : Colors.grey.shade400,
                    width: 1.5,
                  ),
          ),
        );
      }),
    );
  }

  Widget _buildNumpad() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildNumpadRow(['1', '2', '3']),
          const SizedBox(height: 10),
          _buildNumpadRow(['4', '5', '6']),
          const SizedBox(height: 10),
          _buildNumpadRow(['7', '8', '9']),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Left action (Clear or Empty)
              _buildNumpadButton(
                label: 'C',
                isSpecial: true,
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _enteredPin = '';
                    _errorMessage = null;
                  });
                },
              ),
              _buildNumpadButton(
                label: '0',
                onTap: () => _onDigitPressed('0'),
              ),
              _buildNumpadButton(
                icon: Icons.backspace_outlined,
                isSpecial: true,
                onTap: _onBackspacePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumpadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((d) {
        return _buildNumpadButton(
          label: d,
          onTap: () => _onDigitPressed(d),
        );
      }).toList(),
    );
  }

  Widget _buildNumpadButton({
    String? label,
    IconData? icon,
    bool isSpecial = false,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isSpecial
        ? Colors.transparent
        : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade100);

    return Material(
      color: bgColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _isVerifying ? null : onTap,
        child: SizedBox(
          width: 64,
          height: 64,
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    size: 22,
                    color: AppColors.textPrimary(context),
                  )
                : Text(
                    label ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: isSpecial ? FontWeight.w600 : FontWeight.bold,
                      color: isSpecial
                          ? AppColors.textSecondary(context)
                          : AppColors.textPrimary(context),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
