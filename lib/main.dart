import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/privacy_policy_page.dart';
import 'pages/terms_of_service_page.dart';

void main() {
  runApp(const KeedaStudiosApp());
}

class KeedaStudiosApp extends StatelessWidget {
  const KeedaStudiosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Keeda Studios - Mobile Puzzle Game Development',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// GoRouter configuration
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsOfServicePage(),
    ),
  ],
  errorBuilder: (context, state) => const HomePage(),
);
