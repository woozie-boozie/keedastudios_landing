import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../constants/app_colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/games_section.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _gamesKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset(
      'assets/images/snail_2.mp4',
    );

    try {
      await _videoController.initialize();
      await _videoController.setLooping(true);
      await _videoController.setVolume(0);
      await _videoController.play();

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  void _scrollToGames() {
    final context = _gamesKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: Stack(
        children: [
          // Background video layer
          if (_isVideoInitialized)
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
            ),

          // Gradient overlay for better readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundStart.withOpacity(0.8),
                    AppColors.backgroundEnd.withOpacity(0.9),
                    AppColors.backgroundStart.withOpacity(0.95),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero section
                  HeroSection(
                    onExploreTap: _scrollToGames,
                  ),

                  // Games section
                  Container(
                    key: _gamesKey,
                    child: const GamesSection(),
                  ),

                  // About section
                  const AboutSection(),

                  // Contact section
                  const ContactSection(),

                  // Footer
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
