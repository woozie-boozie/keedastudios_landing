import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import 'glass_card.dart';

class GamesSection extends StatelessWidget {
  const GamesSection({super.key});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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
      child: Column(
        children: [
          // Section title
          Text(
            AppStrings.gamesTitle,
            style: isMobile
                ? AppTextStyles.displaySmall
                : (isTablet ? AppTextStyles.displayMedium : AppTextStyles.displayLarge),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.gamesSubtitle,
            style: isMobile ? AppTextStyles.bodyMedium : AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 40 : 60),

          // Games grid
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Wrap(
              spacing: isMobile ? 20 : 30,
              runSpacing: isMobile ? 20 : 30,
              alignment: WrapAlignment.center,
              children: [
                _GameCard(
                  title: AppStrings.crosswordChaosName,
                  description: AppStrings.crosswordChaosDescription,
                  iconPath: 'assets/images/crossword_chaos_icon.png',
                  platforms: const ['iOS', 'Android'],
                  onIOSTap: () => _launchURL(AppStrings.crosswordChaosIOSUrl),
                  onAndroidTap: () => _launchURL(AppStrings.crosswordChaosAndroidUrl),
                  isMobile: isMobile,
                ),
                // Add more games here in the future
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final List<String> platforms;
  final VoidCallback? onIOSTap;
  final VoidCallback? onAndroidTap;
  final bool isMobile;

  const _GameCard({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.platforms,
    this.onIOSTap,
    this.onAndroidTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: isMobile ? double.infinity : 380,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Game icon
          Center(
            child: Container(
              width: isMobile ? 100 : 120,
              height: isMobile ? 100 : 120,
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentPrimary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.apps_rounded,
                        size: 60,
                        color: AppColors.textPrimary.withOpacity(0.7),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Game title
          Text(
            title,
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Platforms
          Wrap(
            spacing: 8,
            children: platforms.map((platform) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.glassBackground,
                  border: Border.all(color: AppColors.glassBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  platform,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 24),

          // Download buttons
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (platforms.contains('iOS') && onIOSTap != null)
                _StoreButton(
                  label: 'App Store',
                  icon: Icons.apple,
                  onPressed: onIOSTap!,
                ),
              if (platforms.contains('iOS') &&
                  platforms.contains('Android') &&
                  onIOSTap != null &&
                  onAndroidTap != null)
                const SizedBox(height: 12),
              if (platforms.contains('Android') && onAndroidTap != null)
                _StoreButton(
                  label: 'Google Play',
                  icon: Icons.android,
                  onPressed: onAndroidTap!,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _StoreButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      borderRadius: 12,
      backgroundColor: AppColors.glassHover,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.buttonSmall,
          ),
        ],
      ),
    );
  }
}
