import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_fadaly_gallery/full_screen_image_page.dart';
import 'package:flutter/material.dart';

class LocationsGalleryPage extends StatelessWidget {
  const LocationsGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[700],
                iconTheme: IconThemeData(color: Colors.white),

        centerTitle: true,
        title: Text(
          "معرض الصور حسب المواقع",
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

          
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance
                    .collection('locations_gallery')
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

              var locations = snapshot.data!.docs;

              return ListView.builder(
                itemCount: locations.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  var location = locations[index];
                  String locationName = location['name'];
                  List<dynamic> images = location['images'];

                  return Card(
                    color:
                        Colors.green[50], 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              locationName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              itemBuilder: (context, imgIndex) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => FullScreenImagePage(
                                                name: locationName,
                                                images: images,
                                                initialIndex: imgIndex,
                                              ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: images[imgIndex],
                                        width: 120,
                                        height: 120,
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
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
