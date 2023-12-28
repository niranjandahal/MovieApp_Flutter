import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:r08fullmovieapp/HomePage/HomePage.dart';
import 'package:r08fullmovieapp/SectionHomeUi/FavoriateList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'repttext.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class drawerfunc extends StatefulWidget {
  drawerfunc({
    super.key,
  });

  @override
  State<drawerfunc> createState() => _drawerfuncState();
}

class _drawerfuncState extends State<drawerfunc> {
  File? _image;

  Future<void> SelectImage() async {
    // final pickedfile =
    //     await ImagePicker().(source: ImageSource.gallery);
    // if (pickedfile != null) {
    //   CroppedFile? cropped = await ImageCropper().cropImage(
    //     sourcePath: pickedfile.path,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //   );
    //   SharedPreferences sp = await SharedPreferences.getInstance();
    //   sp.setString('imagepath', cropped!.path);
    //   _image = cropped as File?;
    // } else {
    //   print('No image selected.');
    // }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      setState(() {
        _image = File(sp.getString('imagepath')!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(18, 18, 18, 0.9),
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await SelectImage();
                        //toast message
                        Fluttertoast.showToast(
                            msg: "Image Changed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: _image == null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/user.png'),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image!),
                            ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            listtilefunc('Home', Icons.home, ontap: () {
              //close drawer
              Navigator.pop(context);
            }),
            listtilefunc('Favorite', Icons.favorite, ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriateMovies()));
            }),
            listtilefunc('Our Blogs', FontAwesomeIcons.blogger,
                ontap: () async {
              //webview for blog
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                          appBar: AppBar(
                            backgroundColor: Color.fromRGBO(18, 18, 18, 0.9),
                            title: Text('Our Blogs'),
                          ),
                          body: WebViewWidget(controller: WebViewController(
                             
                             
                          ),)

                          // body: WebView(
                          //   initialUrl: 'https://niranjandahal.com.np/',
                          //   javascriptMode: JavascriptMode.unrestricted,
                          // ),
                          )));
            }),
            listtilefunc('Our Website', FontAwesomeIcons.solidNewspaper,
                ontap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                            appBar: AppBar(
                              backgroundColor: Color.fromRGBO(18, 18, 18, 0.9),
                              title: Text('Our Website'),
                            ),
                            // body: WebView(
                            //   initialUrl:
                            //       'https://niranjandahalyt.blogspot.com/',
                            //   javascriptMode: JavascriptMode.unrestricted,
                            // ),
                          )));
            }),
            listtilefunc('Subscribe US', FontAwesomeIcons.youtube,
                ontap: () async {
              var url =
                  'https://www.youtube.com/channel/UCeJnnsTq-Lh9E16kCEK49rQ?sub_confirmation=1';
              await launch(url);
            }),
            listtilefunc('About', Icons.info, ontap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Color.fromRGBO(18, 18, 18, 0.9),
                      title: overviewtext(
                          'This App is made by Niranjan Dahal.User can explore,get Details of latest Movies/series.TMDB API is used to fetch data.'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Ok'))
                      ],
                    );
                  });
            }),
            listtilefunc('Quit', Icons.exit_to_app_rounded, ontap: () {
              SystemNavigator.pop();
            }),
          ],
        ),
      ),
    );
  }
}

Widget listtilefunc(String title, IconData icon, {Function? ontap}) {
  return GestureDetector(
    onTap: ontap as void Function()?,
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
