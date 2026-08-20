import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_fadaly_gallery/full_screen_image_page.dart';
import 'package:el_fadaly_gallery/share_gallery_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstructionGalleryPage extends StatelessWidget {
  const ConstructionGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8F6),

      appBar: AppBar(
        backgroundColor: const Color(0xff168044),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'طرق التركيب',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('installation_types')
                .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff168044)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ أثناء تحميل البيانات',
                style: GoogleFonts.cairo(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('لا توجد طرق تركيب', style: GoogleFonts.cairo()),
            );
          }

          final methods = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: methods.length,

            itemBuilder: (context, index) {
              final data = methods[index].data() as Map<String, dynamic>;

              final String name = data['name']?.toString() ?? 'بدون اسم';

              final List<dynamic> images =
                  data['images'] is List
                      ? List<dynamic>.from(data['images'])
                      : [];

              return Container(
                margin: const EdgeInsets.only(bottom: 18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.07),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    // ==================================================
                    // HEADER
                    // ==================================================
                    Padding(
                      padding: const EdgeInsets.all(15),

                      child: Row(
                        children: [
                          // أيقونة طريقة التركيب
                          Container(
                            width: 48,
                            height: 48,

                            decoration: BoxDecoration(
                              color: const Color(0xff8B5E34).withOpacity(.10),

                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.construction_outlined,
                              color: Color(0xff8B5E34),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // الاسم وعدد الصور
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  name,

                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 2),

                                Text(
                                  '${images.length} صورة',

                                  style: GoogleFonts.cairo(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ==================================================
                          // SHARE BUTTON
                          // ==================================================
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff168044).withOpacity(.10),

                              shape: BoxShape.circle,
                            ),

                            child: IconButton(
                              tooltip: 'مشاركة طريقة التركيب',

                              onPressed:
                                  images.isEmpty
                                      ? null
                                      : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => ShareGalleryPage(
                                                  name: name,
                                                  images: images,
                                                ),
                                          ),
                                        );
                                      },

                              icon: const Icon(
                                Icons.share_outlined,

                                color: Color(0xff168044),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ==================================================
                    // IMAGES
                    // ==================================================
                    if (images.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,

                        physics: const NeverScrollableScrollPhysics(),

                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),

                        itemCount: images.length,

                        itemBuilder: (context, imgIndex) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => FullScreenImagePage(
                                        name: name,
                                        images: images,
                                        initialIndex: imgIndex,
                                      ),
                                ),
                              );
                            },

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),

                              child: CachedNetworkImage(
                                imageUrl: images[imgIndex].toString(),

                                fit: BoxFit.cover,

                                placeholder:
                                    (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xff168044),
                                      ),
                                    ),

                                errorWidget:
                                    (context, url, error) => const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.red,
                                      ),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),

                    // ==================================================
                    // NO IMAGES
                    // ==================================================
                    if (images.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              size: 40,
                              color: Colors.grey.shade400,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'لا توجد صور لطريقة التركيب',

                              style: GoogleFonts.cairo(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
