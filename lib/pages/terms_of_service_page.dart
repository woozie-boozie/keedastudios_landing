import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import '../widgets/glass_card.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

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
                          'Terms of Service',
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
                              title: '1. Agreement to Terms',
                              content:
                                  'By accessing or using any games or services provided by ${AppStrings.companyNameLLC}, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our services.',
                            ),
                            _Section(
                              title: '2. Use License',
                              content:
                                  '${AppStrings.companyNameLLC} grants you a limited, non-exclusive, non-transferable license to use our games and services for personal, non-commercial purposes. You may not:\n\n'
                                  '• Modify or copy our games or materials\n'
                                  '• Use our services for commercial purposes\n'
                                  '• Attempt to reverse engineer any software\n'
                                  '• Remove any copyright or proprietary notations\n'
                                  '• Transfer the materials to another person',
                            ),
                            _Section(
                              title: '3. User Accounts',
                              content:
                                  'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account. ${AppStrings.companyNameLLC} reserves the right to terminate accounts that violate these terms.',
                            ),
                            _Section(
                              title: '4. User Conduct',
                              content:
                                  'When using our services, you agree not to:\n\n'
                                  '• Violate any applicable laws or regulations\n'
                                  '• Infringe on intellectual property rights\n'
                                  '• Transmit harmful or malicious code\n'
                                  '• Harass or harm other users\n'
                                  '• Attempt to gain unauthorized access\n'
                                  '• Interfere with the proper functioning of our services',
                            ),
                            _Section(
                              title: '5. Intellectual Property',
                              content:
                                  'All content, features, and functionality of our games and services are owned by ${AppStrings.companyNameLLC} and are protected by international copyright, trademark, and other intellectual property laws.',
                            ),
                            _Section(
                              title: '6. Disclaimers',
                              content:
                                  'The services provided by ${AppStrings.companyNameLLC} are offered "as is" and "as available" without any warranties of any kind, either express or implied. ${AppStrings.companyNameLLC} does not warrant that:\n\n'
                                  '• The services will be uninterrupted or error-free\n'
                                  '• Defects will be corrected\n'
                                  '• The services are free of viruses or harmful components',
                            ),
                            _Section(
                              title: '7. Limitation of Liability',
                              content:
                                  'To the fullest extent permitted by law, ${AppStrings.companyNameLLC} shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use or inability to use our services.',
                            ),
                            _Section(
                              title: '8. In-App Purchases',
                              content:
                                  'Some of our games may offer in-app purchases. All purchases are final and non-refundable except as required by law. ${AppStrings.companyNameLLC} reserves the right to modify pricing at any time.',
                            ),
                            _Section(
                              title: '9. Modifications to Service',
                              content:
                                  '${AppStrings.companyNameLLC} reserves the right to modify, suspend, or discontinue any part of our services at any time without notice or liability.',
                            ),
                            _Section(
                              title: '10. Changes to Terms',
                              content:
                                  '${AppStrings.companyNameLLC} may revise these Terms of Service at any time. By continuing to use our services after changes are posted, you agree to be bound by the revised terms.',
                            ),
                            _Section(
                              title: '11. Governing Law',
                              content:
                                  'These terms shall be governed by and construed in accordance with the laws of the jurisdiction in which ${AppStrings.companyNameLLC} operates, without regard to its conflict of law provisions.',
                            ),
                            _Section(
                              title: '12. Contact Information',
                              content:
                                  'If you have any questions about these Terms of Service, please contact ${AppStrings.companyNameLLC} at:\n\n'
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
