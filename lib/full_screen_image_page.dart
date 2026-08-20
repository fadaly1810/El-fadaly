import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';

class FullScreenImagePage extends StatefulWidget {
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
  State<FullScreenImagePage> createState() =>
      _FullScreenImagePageState();
}

class _FullScreenImagePageState
    extends State<FullScreenImagePage> {
  late PageController controller;
  late int currentIndex;

  bool isSharing = false;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    controller = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // ============================================================
  // SHARE CURRENT IMAGE
  // ============================================================

  Future<void> _shareCurrentImage() async {
    if (isSharing) return;

    setState(() {
      isSharing = true;
    });

    try {
      final String imageUrl =
          widget.images[currentIndex].toString();

      // تحميل الصورة
      final response = await http.get(
        Uri.parse(imageUrl),
      );

      if (response.statusCode != 200) {
        throw Exception('فشل تحميل الصورة');
      }

      final Uint8List bytes = response.bodyBytes;

      final XFile imageFile = XFile.fromData(
        bytes,
        mimeType: 'image/jpeg',
        name:
            'El_Fadaly_${currentIndex + 1}.jpg',
      );

      // ========================================================
      // SHARE_PLUS 10.1.4
      // ========================================================

      await Share.shareXFiles(
        [imageFile],
        text:
            'El Fadaly For Landscaping\n'
            '${widget.name}\n'
            'صورة من معرض أعمال الشركة',
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'حدث خطأ أثناء مشاركة الصورة',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSharing = false;
        });
      }
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: Column(
          children: [
            Text(
              widget.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              '${currentIndex + 1} / ${widget.images.length}',

              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),

        // ======================================================
        // SHARE BUTTON
        // ======================================================

        actions: [
          IconButton(
            tooltip: 'مشاركة الصورة',

            onPressed:
                isSharing
                    ? null
                    : _shareCurrentImage,

            icon: isSharing
                ? const SizedBox(
                    width: 21,
                    height: 21,

                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
          ),

          const SizedBox(width: 5),
        ],
      ),

      // ========================================================
      // IMAGES
      // ========================================================

      body: Stack(
        children: [

          PhotoViewGallery.builder(
            itemCount: widget.images.length,

            pageController: controller,

            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            scrollPhysics:
                const BouncingScrollPhysics(),

            backgroundDecoration:
                const BoxDecoration(
              color: Colors.black,
            ),

            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  widget.images[index].toString(),
                ),

                minScale:
                    PhotoViewComputedScale.contained,

                maxScale:
                    PhotoViewComputedScale.covered * 3,

                heroAttributes:
                    PhotoViewHeroAttributes(
                  tag:
                      '${widget.name}_$index',
                ),
              );
            },
          ),

          // ======================================================
          // BOTTOM COUNTER
          // ======================================================

          Positioned(
            bottom: 25,
            left: 0,
            right: 0,

            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 9,
                ),

                decoration: BoxDecoration(
                  color:
                      Colors.black.withOpacity(.65),

                  borderRadius:
                      BorderRadius.circular(30),

                  border: Border.all(
                    color:
                        Colors.white.withOpacity(.15),
                  ),
                ),

                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white70,
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      '${currentIndex + 1} / ${widget.images.length}',

                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}