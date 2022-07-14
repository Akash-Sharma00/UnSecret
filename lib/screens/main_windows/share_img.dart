import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/screens/main_windows/home_page.dart';

class ShareImg extends StatefulWidget {
  final String header, dpulr, id;
  const ShareImg(
      {Key? key, required this.id, required this.header, required this.dpulr})
      : super(key: key);

  @override
  State<ShareImg> createState() => _ShareImgState();
}

class _ShareImgState extends State<ShareImg> {
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
        title: Text("Share in ${widget.header}"),
      ),
      body: Center(
          child: Column(
        children: [
          
          image == null
              ? Image.asset('asset/default_profile.png',
                  height: 160, width: 160, fit: BoxFit.cover)
              : Image.file(image!,height: MediaQuery.of(context).size.width *1.2, fit: BoxFit.cover),
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
                        "global-chat/${widget.id}", image!);
                    if (task == null) return;
                    final snapShot = await task!.whenComplete(() {});
                    final imgUrl = await snapShot.ref.getDownloadURL();

                    fire.saveToGlobal(widget.dpulr, widget.id, null, imgUrl);
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

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
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
            },
            icon: const Icon(Icons.photo),
            label: const Text("Browse From Gallery")),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
            onPressed: () {
              pickPicture(ImageSource.camera);
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text("Click A Picture")),
      ],
    );
  }
}
