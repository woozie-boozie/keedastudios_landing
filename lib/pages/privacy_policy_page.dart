import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import '../widgets/glass_card.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 80,
                vertical: isMobile ? 40 : 60,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      GlassButton(
                        text: AppStrings.backToHome,
                        onPressed: () => context.go('/'),
                        icon: Icons.arrow_back,
                      ),
                      const SizedBox(height: 32),

                      // Title
                      Center(
                        child: Text(
                          'Privacy Policy',
                          style: isMobile
                              ? AppTextStyles.displaySmall
                              : AppTextStyles.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          AppStrings.companyNameLLC,
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.accentPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Last Updated: January 2025',
                          style: AppTextStyles.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Content
                      GlassCard(
                        padding: EdgeInsets.all(isMobile ? 24 : 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Section(
                              title: '1. Introduction',
                              content:
                                  'Welcome to ${AppStrings.companyNameLLC}. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you about how we look after your personal data when you visit our website or use our applications.',
                            ),
                            _Section(
                              title: '2. Information We Collect',
                              content:
                                  '${AppStrings.companyNameLLC} may collect the following types of information:\n\n'
                                  '• Usage data: Information about how you use our games and services\n'
                                  '• Device information: Device type, operating system, and unique device identifiers\n'
                                  '• Game progress and statistics: Your gameplay data and achievements\n'
                                  '• Contact information: Email address if you contact us for support',
                            ),
                            _Section(
                              title: '3. How We Use Your Information',
                              content:
                                  '${AppStrings.companyNameLLC} uses the collected data for the following purposes:\n\n'
                                  '• To provide and maintain our games and services\n'
                                  '• To improve user experience and game functionality\n'
                                  '• To provide customer support\n'
                                  '• To detect and prevent technical issues\n'
                                  '• To send important updates about our services',
                            ),
                            _Section(
                              title: '4. Data Sharing and Disclosure',
                              content:
                                  '${AppStrings.companyNameLLC} does not sell your personal information. We may share information with:\n\n'
                                  '• Service providers who assist in operating our games\n'
                                  '• Analytics providers to help us improve our services\n'
                                  '• Law enforcement when required by law',
                            ),
                            _Section(
                              title: '5. Data Security',
                              content:
                                  '${AppStrings.companyNameLLC} implements appropriate security measures to protect your personal data. However, no method of transmission over the internet is 100% secure.',
                            ),
                            _Section(
                              title: '6. Your Rights',
                              content:
                                  'You have the right to:\n\n'
                                  '• Access your personal data\n'
                                  '• Request correction of your personal data\n'
                                  '• Request deletion of your personal data\n'
                                  '• Withdraw consent for data processing',
                            ),
                            _Section(
                              title: '7. Children\'s Privacy',
                              content:
                                  '${AppStrings.companyNameLLC} does not knowingly collect personal information from children under 13. If you believe we have collected information from a child under 13, please contact us immediately.',
                            ),
                            _Section(
                              title: '8. Changes to This Policy',
                              content:
                                  '${AppStrings.companyNameLLC} may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.',
                            ),
                            _Section(
                              title: '9. Contact Us',
                              content:
                                  'If you have any questions about this Privacy Policy, please contact ${AppStrings.companyNameLLC} at:\n\n'
                                  'Email: ${AppStrings.contactEmail}',
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Back button (bottom)
                      Center(
                        child: GlassButton(
                          text: AppStrings.backToHome,
                          onPressed: () => context.go('/'),
                          icon: Icons.home,
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
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;
  final bool isLast;

  const _Section({
    required this.title,
    required this.content,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h3,
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: AppTextStyles.bodyMedium,
        ),
        if (!isLast) const SizedBox(height: 32),
      ],
    );
  }
}
