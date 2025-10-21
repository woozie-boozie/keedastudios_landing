import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import 'glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // Section title
              Text(
                AppStrings.aboutTitle,
                style: isMobile
                    ? AppTextStyles.displaySmall
                    : (isTablet
                        ? AppTextStyles.displayMedium
                        : AppTextStyles.displayLarge),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 60),

              // Main content card
              GlassCard(
                padding: EdgeInsets.all(isMobile ? 32 : 48),
                child: Column(
                  children: [
                    // Mission statement badges
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _MissionBadge(
                          icon: Icons.stars_rounded,
                          label: 'Quality',
                          isMobile: isMobile,
                        ),
                        _MissionBadge(
                          icon: Icons.palette_rounded,
                          label: 'Creativity',
                          isMobile: isMobile,
                        ),
                        _MissionBadge(
                          icon: Icons.lightbulb_rounded,
                          label: 'Innovation',
                          isMobile: isMobile,
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 32 : 40),

                    // Description
                    Text(
                      AppStrings.aboutDescription,
                      style: isMobile
                          ? AppTextStyles.bodyMedium
                          : AppTextStyles.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MissionBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isMobile;

  const _MissionBadge({
    required this.icon,
    required this.label,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 24,
        vertical: isMobile ? 12 : 16,
      ),
      borderRadius: 16,
      backgroundColor: AppColors.accentPrimary.withOpacity(0.1),
      borderColor: AppColors.accentPrimary.withOpacity(0.3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.textPrimary,
              size: isMobile ? 20 : 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: isMobile ? AppTextStyles.h3 : AppTextStyles.h2,
          ),
        ],
      ),
    );
  }
}
