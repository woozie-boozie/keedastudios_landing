class AdventureChoice {
  final String id;
  final String text;

  const AdventureChoice({
    required this.id,
    required this.text,
  });
}

class AdventurePanel {
  final String id;
  final String dialogueText1;
  final String? dialogueText2;
  final String mascotAsset;
  final String backgroundAsset;
  final List<AdventureChoice>? choices;
  final bool isFinal;

  const AdventurePanel({
    required this.id,
    required this.dialogueText1,
    this.dialogueText2,
    required this.mascotAsset,
    required this.backgroundAsset,
    this.choices,
    this.isFinal = false,
  });
}

class AdventureContent {
  static const panel1 = AdventurePanel(
    id: 'panel1',
    dialogueText1: "Oh! A new friend! Hello there! I'm Keeda, and I've been waiting for someone like you!",
    dialogueText2: "I know a magical place where dreams become games... Want to come explore with me?",
    mascotAsset: 'assets/adventure/mascot/keeda_curious.svg',
    backgroundAsset: 'assets/adventure/backgrounds/bg_garden.svg',
    choices: [
      AdventureChoice(id: 'A', text: "Lead the way, Keeda!"),
      AdventureChoice(id: 'B', text: "Tell me more first..."),
    ],
  );

  static const panel2A = AdventurePanel(
    id: 'panel2A',
    dialogueText1: "Woohoo! I love your spirit!",
    dialogueText2: "On our way, we'll pass through the Puzzle Nebula! Every star here is an idea waiting to become a game!",
    mascotAsset: 'assets/adventure/mascot/keeda_excited.svg',
    backgroundAsset: 'assets/adventure/backgrounds/bg_starry_sky.svg',
    choices: [
      AdventureChoice(id: 'A1', text: "That's amazing!"),
      AdventureChoice(id: 'A2', text: "I want to see those games!"),
    ],
  );

  static const panel2B = AdventurePanel(
    id: 'panel2B',
    dialogueText1: "Oh, you're thoughtful! I like that! Let me tell you...",
    dialogueText2: "Where I'm from, we craft puzzle games that challenge your mind and warm your heart. We believe games should be fun for everyone!",
    mascotAsset: 'assets/adventure/mascot/keeda_thoughtful.svg',
    backgroundAsset: 'assets/adventure/backgrounds/bg_workshop.svg',
    choices: [
      AdventureChoice(id: 'B1', text: "Sounds wonderful!"),
      AdventureChoice(id: 'B2', text: "Let's go see!"),
    ],
  );

  static const panel3Enthusiastic = AdventurePanel(
    id: 'panel3',
    dialogueText1: "And here we are! Welcome to Keeda Studios!",
    dialogueText2: "This is where the magic happens! Ready to explore our games?",
    mascotAsset: 'assets/adventure/mascot/keeda_welcoming.svg',
    backgroundAsset: 'assets/adventure/backgrounds/bg_studio.svg',
    isFinal: true,
  );

  static const panel3Curious = AdventurePanel(
    id: 'panel3',
    dialogueText1: "Welcome, friend! You've arrived at Keeda Studios!",
    dialogueText2: "I knew you'd love it here! Let me show you what we've been working on...",
    mascotAsset: 'assets/adventure/mascot/keeda_welcoming.svg',
    backgroundAsset: 'assets/adventure/backgrounds/bg_studio.svg',
    isFinal: true,
  );

  static AdventurePanel getPanel2(String choice) {
    return choice == 'A' ? panel2A : panel2B;
  }

  static AdventurePanel getPanel3(String path) {
    return path.startsWith('A') ? panel3Enthusiastic : panel3Curious;
  }
}
