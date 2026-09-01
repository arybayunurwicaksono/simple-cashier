import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _NotificationModel {
  final String id;
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final Duration duration;

  _NotificationModel({
    required this.id,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
    required this.duration,
  });
}

/// Top-anchored stacked notification banner utility displayed directly BELOW the active AppBar or top safe area.
/// Features a fluid 420ms easeInOutCubic spatial animation so older notifications noticeably glide down to make room for new ones.
abstract class AppNotification {
  static final GlobalKey appBarKey = GlobalKey(debugLabel: 'AppNotificationAppBarKey');
  static OverlayEntry? _overlayEntry;
  static final List<_NotificationModel> _activeItems = [];
  static final _containerKey = GlobalKey<_StackedNotificationContainerState>();

  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = const Color(0xFF0F172A),
    Color textColor = Colors.white,
    IconData? icon = Icons.info_outline_rounded,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.maybeOf(context, rootOverlay: true) ?? Overlay.maybeOf(context);
    if (overlay == null) return;

    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final newItem = _NotificationModel(
      id: id,
      message: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      duration: duration,
    );

    // Insert new notification at top of stack (newest first)
    _activeItems.insert(0, newItem);

    // Limit to maximum 3 visible stacked notifications at a time
    if (_activeItems.length > 3) {
      _activeItems.removeLast();
    }

    if (_overlayEntry == null || !_overlayEntry!.mounted) {
      _overlayEntry?.remove();
      _overlayEntry = OverlayEntry(
        builder: (ctx) {
          return _StackedNotificationContainer(
            key: _containerKey,
            items: _activeItems,
            onDismissItem: (itemId) => _removeItem(itemId),
          );
        },
      );
      overlay.insert(_overlayEntry!);
    } else {
      _containerKey.currentState?.updateItems(_activeItems);
    }
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: const Color(0xFF10B981),
      textColor: Colors.white,
      icon: Icons.check_circle_rounded,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      backgroundColor: const Color(0xFFEF4444),
      textColor: Colors.white,
      icon: Icons.error_rounded,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: const Color(0xFF3B82F6),
      textColor: Colors.white,
      icon: Icons.info_rounded,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    IconData? icon = Icons.warning_amber_rounded,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: const Color(0xFFF59E0B),
      textColor: Colors.white,
      icon: icon,
      duration: duration,
    );
  }

  static void _removeItem(String id) {
    _activeItems.removeWhere((item) => item.id == id);
    if (_activeItems.isEmpty) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _containerKey.currentState?.updateItems(_activeItems);
    }
  }

  /// Remove all active notifications immediately
  static void clear() {
    _activeItems.clear();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _StackedNotificationContainer extends StatefulWidget {
  final List<_NotificationModel> items;
  final Function(String id) onDismissItem;

  const _StackedNotificationContainer({
    super.key,
    required this.items,
    required this.onDismissItem,
  });

  @override
  State<_StackedNotificationContainer> createState() =>
      _StackedNotificationContainerState();
}

class _StackedNotificationContainerState
    extends State<_StackedNotificationContainer> {
  late List<_NotificationModel> _currentItems;

  @override
  void initState() {
    super.initState();
    _currentItems = List.from(widget.items);
  }

  void updateItems(List<_NotificationModel> newItems) {
    if (mounted) {
      setState(() {
        _currentItems = List.from(newItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // Base Y coordinate anchored below active AppBar or top safe area
    double baseTop = mediaQuery.padding.top + kToolbarHeight + 12.0;

    if (AppNotification.appBarKey.currentContext != null) {
      final renderBox =
          AppNotification.appBarKey.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        final position = renderBox.localToGlobal(Offset.zero);
        baseTop = position.dy + renderBox.size.height + 10.0;
      }
    }

    return Stack(
      children: [
        // Paint from oldest to newest so newest notification sits on top of Z-stack
        for (int i = _currentItems.length - 1; i >= 0; i--) ...[
          _AnimatedNotificationCard(
            key: ValueKey(_currentItems[i].id),
            item: _currentItems[i],
            index: i,
            baseTop: baseTop,
            onDismiss: widget.onDismissItem,
          ),
        ],
      ],
    );
  }
}

class _AnimatedNotificationCard extends StatefulWidget {
  final _NotificationModel item;
  final int index;
  final double baseTop;
  final Function(String id) onDismiss;

  const _AnimatedNotificationCard({
    required super.key,
    required this.item,
    required this.index,
    required this.baseTop,
    required this.onDismiss,
  });

  @override
  State<_AnimatedNotificationCard> createState() => _AnimatedNotificationCardState();
}

class _AnimatedNotificationCardState extends State<_AnimatedNotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;
  Timer? _autoDismissTimer;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.08, 1.0, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0.0, -0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnim = Tween<double>(
      begin: 0.94,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();

    // Auto dismiss timer with exit fade-out animation
    _autoDismissTimer = Timer(widget.item.duration, () {
      _dismissWithAnimation();
    });
  }

  Future<void> _dismissWithAnimation() async {
    if (_isDismissing) return;
    _isDismissing = true;
    _autoDismissTimer?.cancel();
    if (mounted) {
      await _controller.reverse();
      if (mounted) {
        widget.onDismiss(widget.item.id);
      }
    }
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generous 66px vertical step so each stacked card visibly travels down along a clear path
    final double cardTop = widget.baseTop + (widget.index * 66.0);
    final double targetOpacity = widget.index > 2 ? 0.0 : 1.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeInOutCubic,
      top: cardTop,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: AnimatedOpacity(
              opacity: targetOpacity,
              duration: const Duration(milliseconds: 300),
              child: Material(
                color: Colors.transparent,
                child: Dismissible(
                  key: Key(widget.item.id),
                  direction: DismissDirection.up,
                  onDismissed: (_) {
                    _autoDismissTimer?.cancel();
                    widget.onDismiss(widget.item.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: widget.item.backgroundColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.22),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        if (widget.item.icon != null) ...[
                          Icon(widget.item.icon, color: widget.item.textColor, size: 20),
                          const SizedBox(width: 10),
                        ],
                        Expanded(
                          child: Text(
                            widget.item.message,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: widget.item.textColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: _dismissWithAnimation,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.close_rounded,
                              size: 16,
                              color: widget.item.textColor.withValues(alpha: 0.85),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
