import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../constants/app_colors.dart';
import '../glass_card.dart';

class AdventureDialogue extends StatefulWidget {
  final String text1;
  final String? text2;
  final VoidCallback? onComplete;

  const AdventureDialogue({
    super.key,
    required this.text1,
    this.text2,
    this.onComplete,
  });

  @override
  State<AdventureDialogue> createState() => _AdventureDialogueState();
}

class _AdventureDialogueState extends State<AdventureDialogue> {
  bool _showSecondText = false;
  bool _isComplete = false;

  @override
  void didUpdateWidget(AdventureDialogue oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text1 != widget.text1 || oldWidget.text2 != widget.text2) {
      setState(() {
        _showSecondText = false;
        _isComplete = false;
      });
    }
  }

  void _onFirstTextComplete() {
    if (widget.text2 != null) {
      setState(() {
        _showSecondText = true;
      });
    } else {
      _onAllComplete();
    }
  }

  void _onAllComplete() {
    setState(() {
      _isComplete = true;
    });
    widget.onComplete?.call();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      borderRadius: 20,
      backgroundColor: AppColors.glassBackground.withOpacity(0.15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedText(
            widget.text1,
            onComplete: _onFirstTextComplete,
            key: ValueKey('text1_${widget.text1}'),
          ),
          if (_showSecondText && widget.text2 != null) ...[
            const SizedBox(height: 16),
            _buildAnimatedText(
              widget.text2!,
              onComplete: _onAllComplete,
              key: ValueKey('text2_${widget.text2}'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedText(String text, {VoidCallback? onComplete, Key? key}) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return AnimatedTextKit(
      key: key,
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          speed: const Duration(milliseconds: 35),
          textStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isMobile ? 16 : 20,
            fontWeight: FontWeight.w400,
            height: 1.6,
          ),
        ),
      ],
      isRepeatingAnimation: false,
      onFinished: onComplete,
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
