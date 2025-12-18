import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';

class AdventureBackground extends StatelessWidget {
  final String assetPath;

  const AdventureBackground({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.backgroundStart,
                AppColors.backgroundEnd,
              ],
            ),
          ),
        ),
        // SVG background with fade
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: SvgPicture.asset(
              assetPath,
              key: ValueKey(assetPath),
              fit: BoxFit.cover,
              placeholderBuilder: (context) => const SizedBox.shrink(),
            ),
          ),
        ),
        // Overlay gradient for better text readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
