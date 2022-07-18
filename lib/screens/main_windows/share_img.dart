import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unsecret/connect_to_fire.dart';

class ShareImg extends StatefulWidget {
  final String header, id, des;
  final String? dpulr, pid;
  const ShareImg(
      {Key? key,
      required this.id,
      required this.header,
      this.dpulr,
      required this.des,
      this.pid})
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
      var compressedImg = await FlutterImageCompress.compressAndGetFile(
          imagePath.absolute.path, "${imagePath.path}cmporessed.jpg",
          quality: 30);
      setState(() {
        this.image = compressedImg;
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  var isVisible = false;

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
              ? const Icon(
                  Icons.image,
                  size: 160,
                  color: Colors.green,
                )
              : Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5),
                  child: Image.file(image!, fit: BoxFit.cover)),
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
                label: const Text("Share an image")),
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    setState(() {
                      isVisible = true;
                    });
                    task = ConnectToFire.uploadImg(
                        "global-chat/${widget.id}/${DateTime.now()}", image!);
                    if (task == null) return;
                    final snapShot = await task!.whenComplete(() {});
                    final imgUrl = await snapShot.ref.getDownloadURL();
                    switch (widget.des) {
                      case 'global':
                        fire.saveToGlobal(
                            widget.dpulr, widget.id, null, imgUrl);
                        Navigator.of(context).pop();

                        return;
                      case 'personal':
                        fire.saveAllChat(widget.pid, widget.id, null, imgUrl);
                        Navigator.of(context).pop();

                        return;
                      default:
                        break;
                    }
                  } catch (e) {
                    isVisible = false;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          "Error: Please Select an Image To Proceed",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )));
                    return;
                  }
                },
                icon: const Icon(Icons.share),
                label: const Text("Share")),
          ),
          const SizedBox(height: 10),
          Visibility(
              visible: isVisible, child: const CircularProgressIndicator())
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
