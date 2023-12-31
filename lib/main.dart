import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:pet_book/profile/UserProfilePage.dart';
import 'package:pet_book/profile/profile.dart';
import 'auth/homepage.dart';
import 'auth/login.dart';
import 'auth/forgetPass.dart';
import 'auth/createAccount.dart';
import 'firebase_options.dart';

Color CustomColor1 = const Color(0xFF00a19d);
Color CustomColor2 = const Color(0xFF8aabca);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(PetbookApp());
}

class PetbookApp extends StatefulWidget {
  @override
  _PetbookAppState createState() => _PetbookAppState();
}

class _PetbookAppState extends State<PetbookApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  void initState() {
    super.initState();
    _themeMode =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petbook',
      themeMode: _themeMode,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF90CAF9),
        hintColor: Color(0xFF00a19d),
        colorScheme: ColorScheme.light(
          primary: CustomColor1,
          secondary: Colors.white,
          background: Color(0xFFFFF9C4),
        ),
        scaffoldBackgroundColor: Color(0xFFFFF9C4),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF00a19d)),
          bodyMedium: TextStyle(color: Color(0xFFA1887F)),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF3F51B5),
        hintColor: Color(0xFF263F60),
        colorScheme: ColorScheme.light(
          primary: CustomColor2,
          secondary: Colors.black,
          background: Color(0xFF273443),
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.grey),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(setThemeMode: _setThemeMode), // Pass _themeMode to MyLogin
      routes: {
        'homepage': (context) => HomePage(setThemeMode: _setThemeMode),
        'login': (context) =>
            MyLogin(themeMode: _themeMode), // Pass _themeMode to MyLogin
        'forgetpass': (context) => ResetPassword(themeMode: _themeMode),
        'register': (context) => createAcc(),
        'profile': (context) => UserProfilePage(),
      },
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: child,
        );
      },
    );
  }
}
