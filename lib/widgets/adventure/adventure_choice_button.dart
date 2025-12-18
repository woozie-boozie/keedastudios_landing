import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdventureChoiceButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const AdventureChoiceButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  State<AdventureChoiceButton> createState() => _AdventureChoiceButtonState();
}

class _AdventureChoiceButtonState extends State<AdventureChoiceButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: widget.enabled ? 1.0 : 0.5,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: widget.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            if (widget.enabled) widget.onPressed();
          },
          onTapCancel: () => _controller.reverse(),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 32,
                    vertical: isMobile ? 14 : 18,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppColors.accentPrimary.withOpacity(0.25)
                        : AppColors.glassBackground.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isHovered
                          ? AppColors.accentPrimary
                          : AppColors.glassBorder,
                      width: _isHovered ? 2 : 1,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.accentPrimary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 0),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AdventurePrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const AdventurePrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  State<AdventurePrimaryButton> createState() => _AdventurePrimaryButtonState();
}

class _AdventurePrimaryButtonState extends State<AdventurePrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 32 : 48,
            vertical: isMobile ? 16 : 20,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [
                      AppColors.accentPrimary,
                      AppColors.accentSecondary,
                    ]
                  : [
                      AppColors.accentPrimary.withOpacity(0.8),
                      AppColors.accentSecondary.withOpacity(0.8),
                    ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentPrimary.withOpacity(_isHovered ? 0.5 : 0.3),
                blurRadius: _isHovered ? 30 : 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 12),
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: isMobile ? 20 : 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
