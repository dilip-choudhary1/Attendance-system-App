// import 'dart:ffi';

// import 'dart:js';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:interiit/Screens/home_screen.dart';

class Camera extends StatefulWidget {
  //  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? imageFile;

  // void _getFromCamera() async {
  //   XFile? PickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     maxHeight: 600,
  //     maxWidth: 400,
  //   );
  //   setState(() {
  //     var pickedFile = PickedFile;
  //     imageFile = File(pickedFile!.path);
  //   });
  // }

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/22.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const SizedBox(
            height: 50,
          ),
          // imageFile != null
          //     ? Container(
          //         child: Image.file(imageFile!),
          //       ):
          Container(
            padding: const EdgeInsets.only(left: 120, right: 30, top: 100),
            child: Icon(
              Icons.camera_alt,
              color: const Color.fromARGB(255, 250, 81, 3),
              size: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 30, top: 300),
            child: ElevatedButton(
              child:const Text(
                'Capture Image with Camera',
                style:
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
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

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference refrenceDirImage = referenceRoot.child('images');
                // create a reference for the image to be stored
                Reference referenceImageToUpload =
                    refrenceDirImage.child(uniqueaFilename);
                try {
                  // store the file
                  await referenceImageToUpload.putFile(File(file.path));
                  // success:get the download URL

                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title:const  Text('Image Uploaded Successfully'),
                          content:const  Text(
                              'Your Attendance marked Successfully'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'))
                          ],
                        ));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MyRegister()));
                } catch (error) {
                  const SizedBox(
                    height: 20,
                    child: Text('Please upload the image'),
                  );
                }
              },
              style: ButtonStyle(
                
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 19, 243, 49)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 16,fontWeight: FontWeight.normal))),
            ),
          ),
    //       Container(
    //         padding: const EdgeInsets.only(left: 150, right: 30, top: 400),
    //         child: ElevatedButton(
    //           child: const Text(
    //             'Back to Home',
    //             style:
    //                 TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
    //           ),
    //           onPressed: () {
    //             Navigator.of(context).pushReplacement(MaterialPageRoute(
    //                 builder: (context) => const MyRegister()));
    //           },
    //           style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all(
    //                   const Color.fromARGB(255, 243, 19, 224)),
    //               padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
    //               textStyle:
    //                   MaterialStateProperty.all(const TextStyle(fontSize: 16))),
    //         ),
    //       ),
        ],
      ),
      ),
    );
  }
}
