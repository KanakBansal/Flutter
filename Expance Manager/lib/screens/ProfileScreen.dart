import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.auth,
  }) : super(key: key);
  final FirebaseAuth auth;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  void _pickImage(ImageSource source) async {
    final _imagePicker = ImagePicker();
    try {
      final image = await _imagePicker.pickImage(
        source: source,
      );
      final tempImage = File(image!.path);

      setState(() {
        _image = tempImage;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text("From Camera"),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                        },
                      ),
                      ListTile(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        leading: Icon(Icons.image),
                        title: Text("From Gallery"),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                color: Colors.blue,
                height: 180,
                width: 150,
                child: _image != null
                    ? Image.file(_image!)
                    : Center(
                        child: Column(children: [
                          Text(
                            "${widget.auth.currentUser!.displayName!.substring(0, 1).toUpperCase()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Click Here\n  to click \n  or select \n  Picture",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ]),
                      ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Name : ${widget.auth.currentUser!.displayName}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            SizedBox(height: 10),
            Text("Id. : ${widget.auth.currentUser!.email}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
                "${widget.auth.currentUser!.emailVerified ? "Email is Verified" : "Email is Not Verified"}",style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
          ],
        ),
      )),
    );
  }
}
