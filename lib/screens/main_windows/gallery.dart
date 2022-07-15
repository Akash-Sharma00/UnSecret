import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatefulWidget {
  final List<String> pics;
  const Gallery({Key? key, required this.pics}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: PhotoViewGallery.builder(itemCount: widget.pics.length, builder: (context, index){
        final url = widget.pics[0];
        return PhotoViewGalleryPageOptions(imageProvider: NetworkImage(url),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained * 4);
      })),
    );
  }
}
