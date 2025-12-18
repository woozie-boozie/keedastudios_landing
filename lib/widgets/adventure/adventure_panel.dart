import 'package:flutter/material.dart';
import 'adventure_data.dart';
import 'adventure_mascot.dart';
import 'adventure_dialogue.dart';
import 'adventure_choice_button.dart';
import 'adventure_background.dart';

class AdventurePanelWidget extends StatefulWidget {
  final AdventurePanel panel;
  final Function(String) onChoiceSelected;
  final VoidCallback onEnterPressed;
  final bool showChoices;

  const AdventurePanelWidget({
    super.key,
    required this.panel,
    required this.onChoiceSelected,
    required this.onEnterPressed,
    this.showChoices = false,
  });

  @override
  State<AdventurePanelWidget> createState() => _AdventurePanelWidgetState();
}

class _AdventurePanelWidgetState extends State<AdventurePanelWidget> {
  bool _dialogueComplete = false;

  @override
  void didUpdateWidget(AdventurePanelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.panel.id != widget.panel.id) {
      setState(() {
        _dialogueComplete = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background
        AdventureBackground(assetPath: widget.panel.backgroundAsset),

        // Content
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 20 : 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),

                // Mascot
                AdventureMascot(
                  assetPath: widget.panel.mascotAsset,
                  size: isMobile ? 150 : (isTablet ? 180 : 220),
                ),

                SizedBox(height: isMobile ? 24 : 40),

                // Dialogue
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : 600,
                  ),
                  child: AdventureDialogue(
                    text1: widget.panel.dialogueText1,
                    text2: widget.panel.dialogueText2,
                    onComplete: () {
                      setState(() {
                        _dialogueComplete = true;
                      });
                    },
                  ),
                ),

                SizedBox(height: isMobile ? 24 : 40),

                // Choices or Enter button
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: _dialogueComplete ? 1.0 : 0.0,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 400),
                    offset: _dialogueComplete ? Offset.zero : const Offset(0, 0.2),
                    child: _buildActions(isMobile),
                  ),
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(bool isMobile) {
    if (widget.panel.isFinal) {
      return AdventurePrimaryButton(
        text: "Enter Keeda Studios",
        icon: Icons.arrow_forward_rounded,
        onPressed: widget.onEnterPressed,
      );
    }

    if (widget.panel.choices == null || widget.panel.choices!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: widget.panel.choices!.map((choice) {
        return AdventureChoiceButton(
          text: choice.text,
          enabled: _dialogueComplete,
          onPressed: () => widget.onChoiceSelected(choice.id),
        );
      }).toList(),
    );
  }
}
