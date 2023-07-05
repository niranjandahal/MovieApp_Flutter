import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'HomePage/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  String imagepath = sp.getString('imagepath') ?? '';
  runApp(MyApp(
    imagepath: imagepath,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  String imagepath;
  MyApp({
    super.key,
    required this.imagepath,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: intermediatescreen(),
    );
  }
}

class intermediatescreen extends StatefulWidget {
  const intermediatescreen({super.key});

  @override
  State<intermediatescreen> createState() => _intermediatescreenState();
}

class _intermediatescreenState extends State<intermediatescreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      // disableNavigation: true,
      backgroundColor: Color.fromRGBO(18, 18, 18, 1),

      duration: 2000,
      nextScreen: MyHomePage(),
      splash: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/icon.png'),
                          fit: BoxFit.contain)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'By Niranjan dahal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // splash: Image.asset('assets/images/background.jpg'),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
      // centered: false,
    );
  }
}
