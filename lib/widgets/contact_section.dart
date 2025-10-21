import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import 'glass_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: AppStrings.contactEmail,
      query: 'subject=Contact from Keeda Studios Website',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              // Section title
              Text(
                AppStrings.contactTitle,
                style: isMobile
                    ? AppTextStyles.displaySmall
                    : (isTablet
                        ? AppTextStyles.displayMedium
                        : AppTextStyles.displayLarge),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.contactDescription,
                style: isMobile
                    ? AppTextStyles.bodyMedium
                    : AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 60),

              // Contact card
              GlassCard(
                padding: EdgeInsets.all(isMobile ? 32 : 48),
                child: Column(
                  children: [
                    // Email icon
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentPrimary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.email_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email label
                    Text(
                      'Email Us',
                      style: isMobile ? AppTextStyles.h2 : AppTextStyles.h1,
                    ),
                    const SizedBox(height: 16),

                    // Email address (clickable)
                    GestureDetector(
                      onTap: _launchEmail,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.glassBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.accentPrimary.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            AppStrings.contactEmail,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.accentPrimary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.accentPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Contact button
                    GlassButton(
                      text: 'Send Email',
                      onPressed: _launchEmail,
                      isPrimary: true,
                      icon: Icons.send_rounded,
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
