import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livewebtv/controllers/providers/theme_provider.dart';
import 'package:livewebtv/views/homeScreen/home_screen_view.dart';
import 'package:livewebtv/views/splashScreen/splash_screen_view.dart';
import 'package:livewebtv/views/videoPlayerScreen/video_player_view.dart';
import 'package:provider/provider.dart';
import 'controllers/providers/database_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyChla488UouUnWZIgANqpklIUopDfA59YY",
      authDomain: "livewebtv-5a81f.firebaseapp.com",
      projectId: "livewebtv-5a81f",
      storageBucket: "livewebtv-5a81f.appspot.com",
      messagingSenderId: "834882575278",
      appId: "1:834882575278:web:c3ac19aabf5a59be77c63f",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataBaseProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(colorScheme: const ColorScheme.light()).copyWith(
          textTheme: const TextTheme(
            bodyText1: TextStyle(fontFamily: 'marriweather'),
            bodyText2: TextStyle(fontFamily: 'marriweather'),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              TargetPlatform.linux: ZoomPageTransitionsBuilder(),
              TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
              TargetPlatform.windows: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreenView(),
          '/home': (context) => const HomeScreenView(),
          '/player': (context) => const VideoPlayerView(videoIndex: 0),
        },
      ),
    );
  }
}
