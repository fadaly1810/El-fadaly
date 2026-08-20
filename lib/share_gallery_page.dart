import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShareGalleryPage extends StatefulWidget {
  final String name;
  final List<dynamic> images;

  const ShareGalleryPage({
    super.key,
    required this.name,
    required this.images,
  });

  @override
  State<ShareGalleryPage> createState() =>
      _ShareGalleryPageState();
}

class _ShareGalleryPageState
    extends State<ShareGalleryPage> {
  final Set<int> selectedImages = {};

  bool isSharing = false;

  // ==========================================================
  // SELECT / UNSELECT
  // ==========================================================

  void _toggleImage(int index) {
    setState(() {
      if (selectedImages.contains(index)) {
        selectedImages.remove(index);
      } else {
        selectedImages.add(index);
      }
    });
  }

  // ==========================================================
  // SELECT ALL
  // ==========================================================

  void _selectAll() {
    setState(() {
      if (selectedImages.length == widget.images.length) {
        selectedImages.clear();
      } else {
        selectedImages.clear();

        for (int i = 0; i < widget.images.length; i++) {
          selectedImages.add(i);
        }
      }
    });
  }

  // ==========================================================
  // SHARE
  // ==========================================================

  Future<void> _shareSelectedImages() async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'اختار صورة واحدة على الأقل',
          ),
        ),
      );

      return;
    }

    setState(() {
      isSharing = true;
    });

    try {
      final List<XFile> files = [];

      final List<int> indexes =
          selectedImages.toList()..sort();

      // تحميل الصور
      for (final index in indexes) {
        final String imageUrl =
            widget.images[index].toString();

        final response = await http.get(
          Uri.parse(imageUrl),
        );

        if (response.statusCode != 200) {
          continue;
        }

        final Uint8List bytes =
            response.bodyBytes;

        final XFile file = XFile.fromData(
          bytes,
          mimeType: 'image/jpeg',
          name:
              'El_Fadaly_${index + 1}.jpg',
        );

        files.add(file);
      }

      if (files.isEmpty) {
        throw Exception(
          'لم يتم تحميل الصور',
        );
      }

    await Share.shareXFiles(
  files,
  text:
      'El Fadaly For Landscaping\n'
      '${widget.name}\n'
      'صور من معرض أعمال الشركة',
);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'حدث خطأ أثناء مشاركة الصور',
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

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final bool allSelected =
        selectedImages.length ==
            widget.images.length &&
        widget.images.isNotEmpty;

    return Scaffold(
      backgroundColor:
          const Color(0xffF6F8F6),

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor:
            const Color(0xff168044),

        foregroundColor: Colors.white,

        centerTitle: true,

        title: Column(
          children: [
            Text(
              widget.name,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            Text(
              '${selectedImages.length} صورة محددة',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white70,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            tooltip: 'تحديد الكل',
            onPressed: _selectAll,
            icon: Icon(
              allSelected
                  ? Icons.deselect
                  : Icons.select_all,
            ),
          ),
        ],
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: Column(
        children: [

          // ====================================================
          // TOP INFO
          // ====================================================

          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(15),

            color: Colors.white,

            child: Row(
              children: [

                Container(
                  width: 48,
                  height: 48,

                  decoration: BoxDecoration(
                    color: const Color(
                      0xff168044,
                    ).withOpacity(.10),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.photo_library_outlined,
                    color:
                        Color(0xff168044),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        'صور المشروع',
                        style:
                            GoogleFonts.cairo(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        '${widget.images.length} صورة متاحة',
                        style:
                            GoogleFonts.cairo(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: _selectAll,
                  child: Text(
                    allSelected
                        ? 'إلغاء الكل'
                        : 'تحديد الكل',
                    style:
                        GoogleFonts.cairo(
                      color:
                          const Color(
                        0xff168044,
                      ),
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ====================================================
          // IMAGES
          // ====================================================

          Expanded(
            child: GridView.builder(
              padding:
                  const EdgeInsets.all(12),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .95,
              ),

              itemCount:
                  widget.images.length,

              itemBuilder:
                  (context, index) {

                final bool selected =
                    selectedImages
                        .contains(index);

                return GestureDetector(
                  onTap: () =>
                      _toggleImage(index),

                  child: Stack(
                    children: [

                      // ===============================
                      // IMAGE
                      // ===============================

                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          child:
                              CachedNetworkImage(
                            imageUrl:
                                widget.images[
                                  index
                                ].toString(),

                            fit: BoxFit.cover,

                            placeholder:
                                (context, url) =>
                                    const Center(
                              child:
                                  CircularProgressIndicator(
                                color:
                                    Color(
                                  0xff168044,
                                ),
                              ),
                            ),

                            errorWidget:
                                (
                              context,
                              url,
                              error,
                            ) =>
                                    const Center(
                              child: Icon(
                                Icons
                                    .broken_image,
                                size: 40,
                                color:
                                    Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ===============================
                      // SELECTED OVERLAY
                      // ===============================

                      if (selected)
                        Positioned.fill(
                          child: Container(
                            decoration:
                                BoxDecoration(
                              color: const Color(
                                0xff168044,
                              ).withOpacity(.35),

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                18,
                              ),

                              border: Border.all(
                                color:
                                    Colors.white,
                                width: 3,
                              ),
                            ),
                          ),
                        ),

                      // ===============================
                      // CHECK
                      // ===============================

                      Positioned(
                        top: 10,
                        right: 10,

                        child: Container(
                          width: 32,
                          height: 32,

                          decoration:
                              BoxDecoration(
                            color: selected
                                ? const Color(
                                    0xff168044,
                                  )
                                : Colors.black
                                    .withOpacity(
                                    .45,
                                  ),
                            shape:
                                BoxShape.circle,
                            border: Border.all(
                              color:
                                  Colors.white,
                            ),
                          ),

                          child: Icon(
                            selected
                                ? Icons.check
                                : Icons
                                    .add,
                            color:
                                Colors.white,
                            size: 20,
                          ),
                        ),
                      ),

                      // ===============================
                      // NUMBER
                      // ===============================

                      Positioned(
                        bottom: 10,
                        left: 10,

                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),

                          decoration:
                              BoxDecoration(
                            color: Colors.black
                                .withOpacity(
                              .55,
                            ),
                            borderRadius:
                                BorderRadius
                                    .circular(
                              20,
                            ),
                          ),

                          child: Text(
                            '${index + 1}',
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ========================================================
      // SHARE BUTTON
      // ========================================================

      bottomNavigationBar:
          SafeArea(
        child: Container(
          padding:
              const EdgeInsets.fromLTRB(
            15,
            10,
            15,
            15,
          ),

          color: Colors.white,

          child: SizedBox(
            height: 55,

            child: ElevatedButton.icon(
              onPressed:
                  isSharing
                      ? null
                      : _shareSelectedImages,

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xff168044,
                ),

                foregroundColor:
                    Colors.white,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
              ),

              icon: isSharing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                        color:
                            Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.share_outlined,
                    ),

              label: Text(
                isSharing
                    ? 'جاري تجهيز الصور...'
                    : selectedImages.isEmpty
                        ? 'اختر صور للمشاركة'
                        : 'مشاركة ${selectedImages.length} صورة',

                style:
                    GoogleFonts.cairo(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}