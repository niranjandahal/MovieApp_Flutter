// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'HomePage/HomePage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   String imagepath = sp.getString('imagepath') ?? '';
//   runApp(MyApp(
//     imagepath: imagepath,
//   ));

//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//       overlays: [SystemUiOverlay.bottom]);

//   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//   //     overlays: [SystemUiOverlay.bottom]);
// }

// class MyApp extends StatelessWidget {
//   String imagepath;
//   MyApp({
//     super.key,
//     required this.imagepath,
//   });

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       home: intermediatescreen(),
//     );
//   }
// }

// class intermediatescreen extends StatefulWidget {
//   const intermediatescreen({super.key});

//   @override
//   State<intermediatescreen> createState() => _intermediatescreenState();
// }

// class _intermediatescreenState extends State<intermediatescreen> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       // disableNavigation: true,
//       backgroundColor: Color.fromRGBO(18, 18, 18, 1),

//       duration: 2000,
//       nextScreen: MyHomePage(),
//       splash: Container(
//         child: Center(
//           child: Column(
//             children: [
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(bottom: 10),
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('asset/icon.png'),
//                           fit: BoxFit.contain)),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   child: Text(
//                     'By Niranjan dahal',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       // splash: Image.asset('assets/images/background.jpg'),
//       splashTransition: SplashTransition.fadeTransition,
//       splashIconSize: 200,
//       // centered: false,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'HomePage/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// The Main Entry Point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SharedPreferences sp = await SharedPreferences.getInstance();
  String imagepath = sp.getString('imagepath') ?? '';
  runApp(MyApp(imagepath: imagepath));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

// MyApp Widget
class MyApp extends StatelessWidget {
  final String imagepath;
  const MyApp({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context, child) {
        return ForcedMobileView(child: child!); // Wrap with ForcedMobileView
      },
      home: const IntermediateScreen(),
    );
  }
}

// Forced Mobile View Widget
class ForcedMobileView extends StatelessWidget {
  final Widget child;

  const ForcedMobileView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const double mobileWidth = 500;
    const double mobileHeight = 1150;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Force mobile-like dimensions if the screen is larger
    if (screenWidth > mobileWidth || screenHeight > mobileHeight) {
      return Column(
        children: [
          const Text(
            'Zoom out browser to see full screen',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'all features might not work in web',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          const SizedBox(height: 60),
          Center(
            child: Container(
              width: mobileWidth,
              height: mobileHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5), blurRadius: 10),
                ],
              ),
              child: MediaQuery(
                data: MediaQueryData(
                  size: const Size(mobileWidth, mobileHeight),
                  devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
                  padding: MediaQuery.of(context).padding,
                  viewInsets: MediaQuery.of(context).viewInsets,
                ),
                child: child,
              ),
            ),
          ),
        ],
      );
    }

    return child; // Default rendering for mobile-sized screens
  }
}

// Intermediate Screen with Splash Animation
class IntermediateScreen extends StatefulWidget {
  const IntermediateScreen({super.key});

  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      duration: 2000,
      nextScreen: const MyHomePage(),
      splash: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icon.png'),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'By Niranjan Dahal',
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
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
      centered: true,
    );
  }
}
