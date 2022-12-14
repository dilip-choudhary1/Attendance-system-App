// import 'dart:ffi';
// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interiit/Screens/Sign_Up.dart';
import 'package:interiit/Screens/home_screen.dart';
// import 'package:interiit/Screens/profile_screen.dart';
// import 'package:interiit/camera.dart';

void main() async{
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

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // initiallize firebase app
//   // Future<FirebaseApp> _initializeFirebase() async {
//   //   FirebaseApp firebaseApp = await Firebase.initializeApp();
//   //   return firebaseApp;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: initializeFirebase(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return const LoginScreen();
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // login function
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

  @override
  Widget build(BuildContext context) {
    // TextEditingController emailController = TextEditingController();
    // TextEditingController passwordController = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/6.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: const Text(
                '!!! Welcome !!!',
                style: TextStyle(color: Colors.black, fontSize: 45,fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 90),
              child: const Text(
                'Login to your account',
                style: TextStyle(color: Colors.black, fontSize: 33,fontWeight: FontWeight.w500),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          
                          TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            // controller: emailController,
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
                            height: 30,
                          ),
                          TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            // controller: passwordController,

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
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () async {
                                  try {
                                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: email,
                                      password: password
                                    );
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyRegister()));
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('User not found'),
                                              content: const Text('No user found for that email.'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('OK'))
                                              ],
                                            ));
                                      
                                    } else if (e.code == 'wrong-password') {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Wrong password'),
                                              content: const Text('Wrong password provided for that user.'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:const  Text('OK'))
                                              ],
                                            ));
                                      // print('Wrong password provided for that user.');
                                    }
                                  }
                                },
                                child: const Text(
                                  "Login Here",
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
                              'Not registered ? Sign up here     ',
                              style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.normal),
                            ),
                          ),  

                          const SizedBox(
                            height: 14,
                          ),  
                          Container(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            child:
                              RawMaterialButton(
                                fillColor: const Color.fromARGB(255, 231, 6, 100),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const sign_up()));
                                },
                                child: const Text(
                                  'Sign up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      
                                      color: Colors.black,
                                      fontSize: 18),
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
}






// onPressed: () async {
//                   User? user = await loginUsingEmailPassword(
//                       email: emailController.text,
//                       password: passwordController.text,
//                       context: context);
//                   print(user);
//                   if (user != null) {
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: (context) => const MyRegister()));
//                   }
//                 },


// Padding(
//       padding: const EdgeInsets.all(20.0),

      
      
//         child: Column(
            
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "!!! Welcome !!!",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 1, 5, 249),
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 14,
//             ),
//             const Text(
//               "Mark Your Attendance ",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 1, 5, 249),
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
                
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               "Login ",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 44.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 44,
//             ),
//             TextField(
//               controller: emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                   hintText: "User Email",
//                   prefixIcon: Icon(
//                     Icons.mail,
//                     color: Colors.black,
//                   )),
//             ),
//             const SizedBox(
//               height: 26.0,
//             ),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                   hintText: "User Password",
//                   prefixIcon: Icon(
//                     Icons.lock,
//                     color: Colors.black,
//                   )),
//             ),
//             const Text(
//               "Forgot Password ?",
//               style: TextStyle(color: Colors.blue),
//             ),
//             const SizedBox(
//               height: 18,
//             ),
//             Container(
//               width: double.infinity,
//               child: RawMaterialButton(
//                 fillColor: const Color(0xFF0069FE),
//                 elevation: 5,
//                 padding: const EdgeInsets.symmetric(vertical: 20.0),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 onPressed: () async {
//                   User? user = await loginUsingEmailPassword(
//                       email: emailController.text,
//                       password: passwordController.text,
//                       context: context);
//                   print(user);
//                   if (user != null) {
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: (context) => const MyRegister()));
//                   }
//                 },
//                 child: const Text(
//                   "Login Here",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                   ),
//                 ),
//               ),
//             ),
          
//           ],
//         ),
        
//     );



