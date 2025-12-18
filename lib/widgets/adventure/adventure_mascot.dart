import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdventureMascot extends StatefulWidget {
  final String assetPath;
  final double size;

  const AdventureMascot({
    super.key,
    required this.assetPath,
    this.size = 200,
  });

  @override
  State<AdventureMascot> createState() => _AdventureMascotState();
}

class _AdventureMascotState extends State<AdventureMascot>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_bounceAnimation.value),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: SvgPicture.asset(
              widget.assetPath,
              key: ValueKey(widget.assetPath),
              width: widget.size,
              height: widget.size,
              placeholderBuilder: (context) => SizedBox(
                width: widget.size,
                height: widget.size,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
