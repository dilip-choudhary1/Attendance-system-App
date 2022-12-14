// import 'dart:ffi';
// import 'dart:html';
// import 'dart:ffi';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'package:interiit/Screens/profile_screen.dart';
// import 'package:interiit/Screens/home_screen.dart';
import 'package:interiit/camera.dart';
import 'package:interiit/main.dart';
// import 'package:flutter/src/rendering/box.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/20.png'), fit: BoxFit.cover),
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
              padding: const EdgeInsets.only(left: 35, top: 50),
              child: const Text(
                'Mark Your Attendance',
                style: TextStyle(color: Colors.black, fontSize: 33,fontWeight: FontWeight.bold),
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
                                    color: Color.fromARGB(255, 8, 0, 245),
                                  ),
                                ),
                                hintText: "Enter Your Roll number",
                                hintStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,),
                                border: OutlineInputBorder(
                                  
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          Container(
                              width: double.infinity,
                              child: RawMaterialButton(
                                fillColor: const Color.fromARGB(255, 175, 231, 6),
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () async {
                                  // User? user = await loginUsingEmailPassword(
                                  //     email: emailController.text,
                                  //     password: passwordController.text,
                                  //     context: context);
                                  // print(user);
                                  // if (user != null) {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => Camera()));
                                  // }
                                },
                                child: const Text(
                                  "Recognise your face",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          

                          

                          const SizedBox(
                            height: 30,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Check Attendance',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Profile_Screen()));
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text('Are you really want to exist'),
                                                    
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                            builder: (context) => const LoginScreen()));
                                                          },
                                                          child: const Text('Yes')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                            builder: (context) => const MyRegister()));
                                                          },
                                                          child: const Text('No'))    
                                                    ],
                                                  ));
                                },
                                child: const Text(
                                  'Log out',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                style: const ButtonStyle(),
                              ),
                            ],
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


