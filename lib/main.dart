import 'package:cmsapp/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'Loginwidget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const Loginwidget();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else {
              return Container(
                child: Stack(children: [
                  Center(
                    child: Image.asset(
                      "assets/images/backgroundlibrary.jpg",
                      fit: BoxFit.cover,
                      height: height,
                      width: width,
                      color: Colors.black45,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:
                                      Lottie.asset("assets/lottie/Auth.json"),
                            ),
                          ),
                          const SizedBox(height:100,),
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.green,
                              
                              child: ElevatedButton.icon(
                                label: const Text(
                                  "Sign Up with Google",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  final provider =
                                      Provider.of<GoogleSignInProvider>(context,
                                          listen: false);
                                  provider.googleLogin();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.red,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  // onPrimary: Colors.black12,
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   height: 50,
                          //   width: double.infinity,
                          //   color: Colors.transparent,
                          //   child: Shimmer.fromColors(
                          //     baseColor: Colors.white,
                          //     direction: ShimmerDirection.rtl,
                          //     highlightColor: Colors.red,
                          //     child: ElevatedButton.icon(
                          //       label: const Text(
                          //         "Sign in with Google",
                          //         style: TextStyle(color: Colors.black),
                          //       ),
                          //       onPressed: () {},
                          //       icon: const Icon(
                          //         FontAwesomeIcons.google,
                          //         color: Colors.red,
                          //       ),
                          //       style: ElevatedButton.styleFrom(
                          //         primary: Colors.transparent,
                          //         // onPrimary: Colors.black12,
                          //         side: const BorderSide(
                          //           color: Colors.black,
                          //           width: 2,
                          //         ),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                ]),
              );
            }
          }),
    );
  }
}
