import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import 'glass_card.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExploreTap;

  const HeroSection({
    super.key,
    required this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: size.height * 0.85,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
            vertical: 40,
          ),
          child: GlassCard(
            padding: EdgeInsets.all(isMobile ? 32 : (isTablet ? 48 : 64)),
            borderRadius: isMobile ? 24 : 32,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Container(
                  width: isMobile ? 120 : 150,
                  height: isMobile ? 120 : 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentPrimary.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/keeda_logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to KS initials if logo not found
                        return Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.accentGradient,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              'KS',
                              style: TextStyle(
                                fontSize: isMobile ? 32 : 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 32 : 48),

                // Title
                Text(
                  AppStrings.heroTitle,
                  style: isMobile
                      ? AppTextStyles.displaySmall
                      : (isTablet
                          ? AppTextStyles.displayMedium
                          : AppTextStyles.displayLarge),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 16 : 24),

                // Tagline
                Text(
                  AppStrings.heroSubtitle,
                  style: isMobile
                      ? AppTextStyles.h3
                      : (isTablet ? AppTextStyles.h2 : AppTextStyles.h1),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // Description
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    AppStrings.heroDescription,
                    style: isMobile
                        ? AppTextStyles.bodyMedium
                        : AppTextStyles.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: isMobile ? 32 : 48),

                // CTA Button
                GlassButton(
                  text: AppStrings.heroCTA,
                  onPressed: onExploreTap,
                  isPrimary: true,
                  icon: Icons.rocket_launch_rounded,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 40,
                    vertical: isMobile ? 14 : 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
