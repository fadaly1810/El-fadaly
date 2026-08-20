import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';
import 'full_screen_image_page.dart';

class MarbleGalleryPage extends StatelessWidget {
  const MarbleGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8F6),

      appBar: AppBar(
        backgroundColor: const Color(0xff168044),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'خامات الرخام',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('marbles')
            .snapshots(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff168044),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('حدث خطأ في تحميل البيانات'),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('لا توجد خامات حتى الآن'),
            );
          }

          final marbles = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(15),

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 15,
              childAspectRatio: .78,
            ),

            itemCount: marbles.length,

            itemBuilder: (context, index) {

              final data =
                  marbles[index].data()
                      as Map<String, dynamic>;

              final String name =
                  data['name']?.toString() ?? 'بدون اسم';

              final List<dynamic> images =
                  data['images'] is List
                      ? List<dynamic>.from(data['images'])
                      : [];

              final String? imageUrl =
                  images.isNotEmpty
                      ? images.first.toString()
                      : null;

              return GestureDetector(
                onTap: () {

                  if (images.isEmpty) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FullScreenImagePage(
                        name: name,
                        images: images,
                        initialIndex: 0,
                      ),
                    ),
                  );
                },

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(.07),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(18),

                    child: Column(
                      children: [

                        Expanded(
                          child: imageUrl == null
                              ? Container(
                                  color:
                                      Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 45,
                                    color: Colors.grey,
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,

                                  placeholder:
                                      (context, url) =>
                                          const Center(
                                    child:
                                        CircularProgressIndicator(
                                      color:
                                          Color(0xff168044),
                                    ),
                                  ),

                                  errorWidget:
                                      (context, url, error) =>
                                          const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.all(12),

                          child: Row(
                            children: [

                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style:
                                      GoogleFonts.cairo(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),

                              if (images.length > 1)
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color: const Color(
                                      0xff168044,
                                    ).withOpacity(.10),
                                    borderRadius:
                                        BorderRadius
                                            .circular(20),
                                  ),
                                  child: Text(
                                    '${images.length}',
                                    style:
                                        GoogleFonts.cairo(
                                      fontSize: 11,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          const Color(
                                        0xff168044,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}