// import 'dart:convert';

// import 'package:auspower_flutter/constants/keys.dart';
// import 'package:auspower_flutter/models/auth_user.dart';
// import 'package:auspower_flutter/providers/providers.dart';
// import 'package:auspower_flutter/services/storage/storage_constants.dart';
// import 'package:auspower_flutter/view/homescreen.dart';
// import 'package:auspower_flutter/view/homescreen/screen/power_consumption.dart';
// import 'package:auspower_flutter/view/homescreen/screen/sheetview.dart';
// import 'package:auspower_flutter/view/homescreen/screen/top_consumption.dart';
// import 'package:flutter/material.dart';
// import 'package:auspower_flutter/services/route/route_transition.dart';
//
// import 'package:auspower_flutter/view/authentication/screens/login_screen.dart';
// import 'package:auspower_flutter/view/authentication/screens/register_screen.dart';
// import 'package:auspower_flutter/view/authentication/screens/splash_screen.dart';
// import 'package:auspower_flutter/view/main_screen.dart';
// import 'package:auspower_flutter/view/onboarding/screens/onboarding_screen.dart';

// import 'routes.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();
// bool isInitialized = false;
// bool isOnBoarded = false;
// bool isLoggedIn = false;

// // GoRouter configuration
// final GoRouter router = GoRouter(
//   initialLocation: Routes.home,
//   navigatorKey: _rootNavigatorKey,
//   routes: <RouteBase>[
//     ShellRoute(
//       navigatorKey: _shellNavigatorKey,
//       pageBuilder: (context, state, child) {
//         return NoTransitionPage(child: MainScreen(child: child));
//       },
//       routes: [
//         customShellRoute(path: Routes.home, child: const HomeScreen()),
//       ],
//     ),

//     ///Splash
//     customRoute(path: Routes.splash, child: const SplashScreen()),

//     ///OnBoarding
//     customRoute(path: Routes.onboarding, child: const OnBoardingScreen()),

//     ///Auth
//     customRoute(path: Routes.login, child: const LoginScreen()),
//     customRoute(path: Routes.register, child: const RegisterScreen()),
//     customRoute(path: Routes.sheetview, child: const SheetViewScreen()),
//     customRoute(path: Routes.topConsumption, child: MeterDataChart()),
//     customRoute(path: Routes.powerConsumption, child: PowerConsumption()),
//   ],
//   redirect: (context, state) async {
//     if (!isInitialized) return Routes.splash;
//     String value = await storage.read(key: StorageConstants.onboarding) ?? '';
//     String authDetails =
//         await storage.read(key: StorageConstants.authCreds) ?? '';

//     if (value.isEmpty) {
//       if (!isOnBoarded) return Routes.onboarding;
//     }

//     if (authDetails.isEmpty) {
//       if (!isLoggedIn) return Routes.login;
//     }
//     if (authDetails.isNotEmpty) {
//       if (!isLoggedIn) return Routes.home;
//     }

//     return null;
//   },
// );

// GoRoute customShellRoute({required String path, required Widget child}) {
//   return GoRoute(
//       path: path,
//       parentNavigatorKey: _shellNavigatorKey,
//       pageBuilder: (context, state) => NoTransitionPage(child: child));
// }

// GoRoute customRoute({required String path, required Widget child}) {
//   return GoRoute(
//       path: path,
//       parentNavigatorKey: _rootNavigatorKey,
//       pageBuilder: (context, state) => CustomTransitionPage(
//           child: child,
//           transitionsBuilder:
//               RouteTransition(direction: TransitionDirection.left).slide));
// }
