import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_fadaly_gallery/full_screen_image_page.dart';
import 'package:flutter/material.dart';

class MarbleGalleryPage extends StatelessWidget {
  const MarbleGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "El Fadaly For Landscaping",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
         
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/logo.jpg",
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

         
          Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('marbles')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("لا توجد بيانات"));
                    }

                    var marbles = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: marbles.length,
                      itemBuilder: (context, index) {
                        var marble = marbles[index];
                        String name = marble['name'];
                        List<dynamic> images = marble['images'];

                        
                        String imageUrl =
                            images.isNotEmpty
                                ? images[0]
                                : "https://b.top4top.io/p_3370eadte1.jpg";

                        return Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.all(10),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => FullScreenImagePage(
                                            name: name,
                                            images: images,
                                            initialIndex: 0,
                                          ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.green,
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                             
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
