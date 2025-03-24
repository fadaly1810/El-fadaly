import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImagePage extends StatelessWidget {
  final List<dynamic> images;
  final int initialIndex;
  final String name;

  const FullScreenImagePage({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        centerTitle: true,
        title: Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        pageController: PageController(initialPage: initialIndex),
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(color: Colors.green[100]),
      ),
    );
  }
}
