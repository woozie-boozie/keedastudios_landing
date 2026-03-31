import 'dart:async';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_strings.dart';
import 'glass_card.dart';

class GamesSection extends StatefulWidget {
  const GamesSection({super.key});

  @override
  State<GamesSection> createState() => _GamesSectionState();
}

class _GamesSectionState extends State<GamesSection> {
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;
  int _currentPage = 0;
  bool _showCarousel = false;

  @override
  void initState() {
    super.initState();
  }

  void _activateCarousel() {
    setState(() => _showCarousel = true);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(milliseconds: 4500), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % AppStrings.maliScreenPaths.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _resetAutoPlay() {
    _autoPlayTimer?.cancel();
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) _startAutoPlay();
    });
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
    _resetAutoPlay();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
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
                : (isTablet
                    ? AppTextStyles.displayMedium
                    : AppTextStyles.displayLarge),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.gamesSubtitle,
            style: isMobile ? AppTextStyles.bodyMedium : AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 40 : 60),

          // Mali showcase
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile
                ? _buildMaliMobile(size)
                : _buildMaliDesktop(size, isTablet),
          ),

          SizedBox(height: isMobile ? 60 : 80),

          // Crossword Chaos card
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
                  onAndroidTap: () =>
                      _launchURL(AppStrings.crosswordChaosAndroidUrl),
                  isMobile: isMobile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaliDesktop(Size size, bool isTablet) {
    final phoneHeight = isTablet ? 480.0 : 550.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Phone carousel
        SizedBox(
          height: phoneHeight,
          child: _buildPhoneCarousel(phoneHeight),
        ),
        SizedBox(width: isTablet ? 40 : 64),
        // Info panel
        Expanded(child: _buildMaliInfo(false)),
      ],
    );
  }

  Widget _buildMaliMobile(Size size) {
    final phoneHeight = (size.height * 0.55).clamp(350.0, 480.0);

    return Column(
      children: [
        SizedBox(
          height: phoneHeight,
          child: _buildPhoneCarousel(phoneHeight),
        ),
        const SizedBox(height: 32),
        _buildMaliInfo(true),
      ],
    );
  }

  Widget _buildPhoneCarousel(double phoneHeight) {
    if (!_showCarousel) {
      // Show snail image, tap to activate carousel
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _activateCarousel,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AspectRatio(
                  aspectRatio: 1290 / 2796,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: AppColors.glassBorder.withOpacity(0.6),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentPrimary.withOpacity(0.12),
                          blurRadius: 60,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(33),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/snail.PNG',
                            fit: BoxFit.cover,
                          ),
                          // Tap hint overlay
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                    color: AppColors.glassBorder, width: 1),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.touch_app_rounded,
                                      color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Tap to explore',
                                    style: AppTextStyles.bodySmall
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
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
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Phone frame with screenshots
        Expanded(child: _PhoneFrame(
          pageController: _pageController,
          onPageChanged: (page) {
            setState(() => _currentPage = page);
          },
          onManualInteraction: _resetAutoPlay,
        )),
        const SizedBox(height: 20),
        // Navigation dots
        _CarouselDots(
          count: AppStrings.maliScreenPaths.length,
          currentIndex: _currentPage,
          onDotTap: _goToPage,
        ),
      ],
    );
  }

  Widget _buildMaliInfo(bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Mali name with gradient
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.accentGradient.createShader(bounds),
          child: Text(
            AppStrings.maliName,
            style: (isMobile ? AppTextStyles.displaySmall : AppTextStyles.displayMedium)
                .copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.maliTagline,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.maliDescription,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 28),
        // Feature highlights
        _FeatureRow(
          icon: Icons.eco_rounded,
          title: 'AI Plant Care',
          description: 'Personalized advice from Sidney, your garden AI',
        ),
        const SizedBox(height: 12),
        _FeatureRow(
          icon: Icons.cloud_rounded,
          title: 'Weather Aware',
          description: 'Smart reminders based on your local forecast',
        ),
        const SizedBox(height: 12),
        _FeatureRow(
          icon: Icons.dashboard_rounded,
          title: 'Garden Dashboard',
          description: 'Track all your plants in one beautiful view',
        ),
        const SizedBox(height: 28),
        // Coming Soon badge
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          borderRadius: 12,
          borderColor: AppColors.accentPrimary.withOpacity(0.4),
          backgroundColor: AppColors.accentPrimary.withOpacity(0.1),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.rocket_launch_rounded,
                  color: AppColors.accentPrimary, size: 18),
              const SizedBox(width: 8),
              Text(
                AppStrings.maliComingSoon,
                style: AppTextStyles.buttonSmall.copyWith(
                  color: AppColors.accentPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Phone frame widget
class _PhoneFrame extends StatefulWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onManualInteraction;

  const _PhoneFrame({
    required this.pageController,
    required this.onPageChanged,
    required this.onManualInteraction,
  });

  @override
  State<_PhoneFrame> createState() => _PhoneFrameState();
}

class _PhoneFrameState extends State<_PhoneFrame> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // iPhone 6.7" aspect ratio
    const phoneAspectRatio = 1290 / 2796;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AspectRatio(
        aspectRatio: phoneAspectRatio,
        child: Stack(
          children: [
            // Phone body
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                border: Border.all(
                  color: AppColors.glassBorder.withOpacity(0.6),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentPrimary.withOpacity(0.12),
                    blurRadius: 60,
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(33),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollStartNotification &&
                          notification.dragDetails != null) {
                        widget.onManualInteraction();
                      }
                      return false;
                    },
                    child: PageView.builder(
                      controller: widget.pageController,
                      onPageChanged: widget.onPageChanged,
                      itemCount: AppStrings.maliScreenPaths.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          AppStrings.maliScreenPaths[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.backgroundEnd,
                              child: Center(
                                child: Icon(
                                  Icons.image_rounded,
                                  size: 48,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Left arrow
            Positioned(
              left: 4,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _isHovered ? 0.9 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: _ArrowButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () {
                      final prev = (widget.pageController.page?.round() ?? 0) - 1;
                      if (prev >= 0) {
                        widget.pageController.animateToPage(
                          prev,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                        );
                        widget.onManualInteraction();
                      }
                    },
                  ),
                ),
              ),
            ),

            // Right arrow
            Positioned(
              right: 4,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _isHovered ? 0.9 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: _ArrowButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: () {
                      final next = (widget.pageController.page?.round() ?? 0) + 1;
                      if (next < AppStrings.maliScreenPaths.length) {
                        widget.pageController.animateToPage(
                          next,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                        );
                        widget.onManualInteraction();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.glassBorder, width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

class _CarouselDots extends StatelessWidget {
  final int count;
  final int currentIndex;
  final ValueChanged<int> onDotTap;

  const _CarouselDots({
    required this.count,
    required this.currentIndex,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return GestureDetector(
          onTap: () => onDotTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: isActive ? 28 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: isActive ? AppColors.accentGradient : null,
              color: isActive ? null : AppColors.glassBorder,
            ),
          ),
        );
      }),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
