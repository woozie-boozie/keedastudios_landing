import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../services/intro_preferences.dart';
import 'adventure_state.dart';
import 'adventure_panel.dart';

class AdventureIntroWrapper extends StatefulWidget {
  final Widget child;

  const AdventureIntroWrapper({
    super.key,
    required this.child,
  });

  @override
  State<AdventureIntroWrapper> createState() => _AdventureIntroWrapperState();
}

class _AdventureIntroWrapperState extends State<AdventureIntroWrapper>
    with SingleTickerProviderStateMixin {
  bool _showIntro = false;
  bool _isLoading = true;
  bool _isExiting = false;
  late AdventureState _adventureState;
  late AnimationController _exitController;
  late Animation<double> _exitAnimation;

  @override
  void initState() {
    super.initState();
    _adventureState = AdventureState();
    _adventureState.addListener(_onStateChange);

    _exitController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _exitAnimation = CurvedAnimation(
      parent: _exitController,
      curve: Curves.easeInOut,
    );

    _checkIntroStatus();
  }

  @override
  void dispose() {
    _adventureState.removeListener(_onStateChange);
    _adventureState.dispose();
    _exitController.dispose();
    super.dispose();
  }

  void _checkIntroStatus() {
    final hasSeenIntro = IntroPreferences.hasSeenIntro();
    setState(() {
      _showIntro = !hasSeenIntro;
      _isLoading = false;
    });
  }

  void _onStateChange() {
    if (_adventureState.isComplete && !_isExiting) {
      _exitIntro();
    }
  }

  void _exitIntro() {
    setState(() {
      _isExiting = true;
    });
    IntroPreferences.setIntroSeen();
    _exitController.forward().then((_) {
      setState(() {
        _showIntro = false;
        _isExiting = false;
      });
    });
  }

  void _skipIntro() {
    _adventureState.skipIntro();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoading();
    }

    return Stack(
      children: [
        widget.child,
        if (_showIntro)
          AnimatedBuilder(
            animation: _exitAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: 1 - _exitAnimation.value,
                child: Transform.scale(
                  scale: 1 + (_exitAnimation.value * 0.1),
                  child: child,
                ),
              );
            },
            child: AdventureIntro(
              state: _adventureState,
              onSkip: _skipIntro,
            ),
          ),
      ],
    );
  }

  Widget _buildLoading() {
    return Container(
      color: AppColors.backgroundStart,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.accentPrimary,
        ),
      ),
    );
  }
}

class AdventureIntro extends StatelessWidget {
  final AdventureState state;
  final VoidCallback onSkip;

  const AdventureIntro({
    super.key,
    required this.state,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Material(
      color: Colors.transparent,
      child: Container(
        color: AppColors.backgroundStart,
        child: Stack(
          children: [
            // Panel content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.05, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: ListenableBuilder(
                listenable: state,
                builder: (context, _) {
                  return AdventurePanelWidget(
                    key: ValueKey(state.currentPanel.id + state.currentPath),
                    panel: state.currentPanel,
                    onChoiceSelected: state.selectChoice,
                    onEnterPressed: state.completeIntro,
                  );
                },
              ),
            ),

            // Skip button
            Positioned(
              top: isMobile ? 16 : 24,
              right: isMobile ? 16 : 24,
              child: SafeArea(
                child: _SkipButton(onPressed: onSkip),
              ),
            ),

            // Progress indicator
            Positioned(
              bottom: isMobile ? 24 : 40,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Center(
                  child: ListenableBuilder(
                    listenable: state,
                    builder: (context, _) {
                      return _ProgressIndicator(
                        currentIndex: state.currentPanelIndex,
                        totalPanels: 3,
                      );
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

class _SkipButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _SkipButton({required this.onPressed});

  @override
  State<_SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<_SkipButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.glassBackground.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? AppColors.glassBorder
                  : AppColors.glassBorder.withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Skip',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.skip_next_rounded,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalPanels;

  const _ProgressIndicator({
    required this.currentIndex,
    required this.totalPanels,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalPanels, (index) {
        final isActive = index == currentIndex;
        final isPast = index < currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.accentPrimary
                : (isPast
                    ? AppColors.accentPrimary.withOpacity(0.5)
                    : AppColors.glassBorder),
            borderRadius: BorderRadius.circular(4),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.accentPrimary.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
