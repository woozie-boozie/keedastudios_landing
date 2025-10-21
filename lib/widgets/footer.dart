import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 40 : 60,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundStart.withOpacity(0.8),
        border: const Border(
          top: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          if (!isMobile) ...[
            // Desktop layout - single row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Copyright
                Text(
                  AppStrings.copyright,
                  style: AppTextStyles.bodySmall,
                ),
                // Links
                Row(
                  children: [
                    _FooterLink(
                      text: AppStrings.privacyPolicy,
                      onTap: () => context.go('/privacy'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '|',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    _FooterLink(
                      text: AppStrings.termsOfService,
                      onTap: () => context.go('/terms'),
                    ),
                  ],
                ),
              ],
            ),
          ] else ...[
            // Mobile layout - stacked
            Column(
              children: [
                // Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterLink(
                      text: AppStrings.privacyPolicy,
                      onTap: () => context.go('/privacy'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '|',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    _FooterLink(
                      text: AppStrings.termsOfService,
                      onTap: () => context.go('/terms'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Copyright
                Text(
                  AppStrings.copyright,
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}
