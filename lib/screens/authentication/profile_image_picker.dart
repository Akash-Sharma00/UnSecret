import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/screens/main_windows/profile.dart';

class PickImage extends StatefulWidget {
  const PickImage(
      {Key? key,
      required this.name,
      required this.email,
      required this.contact,
      required this.id,
      required this.password})
      : super(key: key);
  final String name, email, contact, id, password;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? image;
  final fire = ConnectToFire();
  UploadTask? task;

  Future pickPicture(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        this.image = imagePath;
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Unsecret"),
        actions: [
          TextButton(
              onPressed: () {
                fire.saveData(widget.name, widget.id, widget.email,
                    widget.contact, widget.password, null);
                fire.saveLocal(widget.name, widget.id, widget.email,
                    widget.contact, false, null);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          ClipOval(
              child: image == null
                  ? Image.asset('asset/default_profile.png',
                      height: 160, width: 160, fit: BoxFit.cover)
                  : Image.file(image!,
                      height: 160, width: 160, fit: BoxFit.cover)),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      enableDrag: false,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      builder: (context) => buildSheet());
                },
                icon: const Icon(Icons.image),
                label: const Text("Select an image")),
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton.icon(
                onPressed: () async {
                  var d = showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      });
                  try {
                    task = ConnectToFire.uploadImg(
                        "profiles/${widget.id}", image!);
                    if (task == null) return;
                    final snapShot = await task!.whenComplete(() {});
                    final imgUrl = await snapShot.ref.getDownloadURL();
                    fire.saveData(widget.name, widget.id, widget.email,
                        widget.contact, widget.password, imgUrl.toString());
                    fire.saveLocal(widget.name, widget.id, widget.email,
                        widget.contact, false, imgUrl.toString());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          "Error: Please Select an Image To Proceed",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )));
                    Navigator.pop(await d);

                    return;
                  }

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                icon: const Icon(Icons.upload),
                label: const Text("Upload Profile Image")),
          ),
        ],
      )),
    );
  }

  Widget buildSheet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Select an option",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
            onPressed: () {
              pickPicture(ImageSource.gallery);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.photo),
            label: const Text("Browse From Gallery")),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
            onPressed: () {
              pickPicture(ImageSource.camera);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text("Click A Picture")),
      ],
    );
  }
}
