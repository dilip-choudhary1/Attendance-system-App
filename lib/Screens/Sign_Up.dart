import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:interiit/Screens/home_screen.dart';
import 'package:interiit/main.dart';
// import 'package:interiit/firebase services/Authentication.dart';
// import 'package:interiit/Screens/profile_screen.dart';
// import 'package:interiit/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // initiallize firebase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const sign_up();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  // static Future<User?> loginUsingEmailPassword(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       print("Email is not registered with us");
  //     }
  //   }
  //   return user;
  // }

  String email = '';
  String password = '';
  // String image = '';

  String imageUrl = '';
  var loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/6.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: const Text(
                'Attendance System',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 115, top: 85),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 35, right: 35),
                            width: double.infinity,
                            child: RawMaterialButton(
                              fillColor: const Color.fromARGB(255, 236, 187, 9),
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? file = await ImagePicker().pickImage(
                                  source: ImageSource.camera,
                                  maxHeight: 600,
                                  maxWidth: 400,
                                );
                                // print('${file?.path}');
                                if (file == null) return;

                                String uniqueaFilename = 
                                DateTime.now().millisecondsSinceEpoch.toString();

                                // get a reference to storage root

                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference refrenceDirImage =
                                    referenceRoot.child('Sign up images');
                                // create a reference for the image to be stored
                                Reference referenceImageToUpload =
                                    refrenceDirImage.child(uniqueaFilename);
                                try {
                                  // store the file
                                  await referenceImageToUpload
                                      .putFile(File(file.path));
                                  // success:get the download URL

                                  imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                  await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title:const  Text('Image Uploaded Successfully'),
                                            content:const  Text(
                                                'Now, Sign up using email and password'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'))
                                            ],
                                          ));
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => const sign_up()));
                                } catch (error) {
                                  const SizedBox(
                                    height: 20,
                                    child: Text('Please upload the image'),
                                  );
                                }
                              },
                              child: const Text(
                                "Upload Your Image",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Enter your email",
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            controller: passwordController,
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Enter your password",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            child: RawMaterialButton(
                              fillColor: const Color.fromARGB(255, 236, 9, 9),
                              elevation: 5,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () async {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                                  await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('Sign up Succeeded'),
                                            content: const Text(
                                                'Your account is created, you can log in now'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'))
                                            ],
                                          ));

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Weak Password'),
                                              content: const Text('Entered password is weak \n Try strong password'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('OK'))
                                              ],
                                            ));
                                    // print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Email already exist'),
                                              content: const Text('Entered email is already exist\nTry to log in'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('OK'))
                                              ],
                                            ));
                                    // print(
                                    //     'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('Unknown error occured'),
                                            // content: Text('Your account is created, you can log in now'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'))
                                            ],
                                          ));
                                  // print(e);
                                }
                              },
                              child: const Text(
                                "Sign up Here",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 35, top: 10),
                            child: const Text(
                              'Already registered ? Log in here     ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            child: RawMaterialButton(
                              fillColor: const Color.fromARGB(255, 231, 6, 100),
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text(
                                'Log In',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              // style: const ButtonStyle(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future _signUp() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);

  //     await FirebaseFirestore.instance.collection("users").add({
  //       'email': emailController.text,
  //       'password': passwordController.text,
  //     });

      // await showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //           title: Text('Sign up Succeeded'),
      //           content: Text('Your account is created, you can log in now'),
      //           actions: [
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 child: Text('OK'))
      //           ],
      //         ));
  //     Navigator.of(context).pop();
  //   } on FirebaseAuthException catch (e) {
  //     void _handleSignUperror(FirebaseAuthException e) {
  //       String massageToDisplay;
  //       switch (e.code) {
  //         case 'email-already-in-use':
  //           massageToDisplay = 'This email is already in use';
  //           break;
  //       }
  //     }
  //   }

}
