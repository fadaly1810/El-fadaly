import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MarbleGalleryPage extends StatelessWidget {
  const MarbleGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset('assets/logo.jpg'),
        centerTitle: true,
        title: Text(
          "El Fadaly For Landscaping",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Info()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('marbles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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

              return Card(
                color: Colors.green[50],

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          name,
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
                                            imageUrl: images[imgIndex],
                                          ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    images[imgIndex],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
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
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          boundaryMargin: EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        centerTitle: true,
        title: Text(
          "معلومات التواصل",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.green[50],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // اللوجو
                Image.asset('assets/logo.jpg', height: 100),
                SizedBox(height: 10),

                // اسم الشركة
                Text(
                  "El Fadaly For Landscaping",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),

                SizedBox(height: 10),
                Divider(thickness: 1, color: Colors.grey[300]),

                // العنوان
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 5),
                    Text("📍 الشيخ زايد", style: TextStyle(fontSize: 18)),
                  ],
                ),

                SizedBox(height: 10),
                Divider(thickness: 1, color: Colors.grey[300]),

                // صاحب الشركة
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.business, color: Colors.brown),
                    SizedBox(width: 5),
                    Text(
                      "👤 صاحب الشركة: م/ شعبان محمد فضالي",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Divider(thickness: 1, color: Colors.grey[300]),

                // أرقام الهواتف
                _buildPhoneRow("م/ شعبان محمد", "01229007512"),
                _buildPhoneRow("م/ محمد شعبان", "01114234856"),
                _buildPhoneRow("م/ محمد شعبان", "01099657323"),
                _buildPhoneRow("م/ يوسف شعبان", "01090438638"),
                _buildPhoneRow("م/ احمد شعبان", "01156634220"),

                SizedBox(height: 15),

                // الإيميل
                GestureDetector(
                  onTap: () => _sendEmail("shaban.fadaly@yahoo.com"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        "Shaban.fadaly@yahoo.com",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // رابط صفحة الفيسبوك
                GestureDetector(
                  onTap: _launchFacebookPage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook, color: Colors.blue, size: 30),
                      SizedBox(width: 5),
                      Text(
                        "صفحة الفيسبوك",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneRow(String name, String phoneNumber) {
    return GestureDetector(
      onTap: () => _makePhoneCall(phoneNumber),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone, color: Colors.green),
            FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
            SizedBox(width: 8),
            Text(
              " $name: $phoneNumber",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "لا يمكن فتح تطبيق الاتصال!";
    }
  }
//15154
  void _sendEmail(String email) async {
    final Uri emailUri = Uri.parse("mailto:$email");
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw "لا يمكن فتح تطبيق البريد الإلكتروني!";
    }
  }

  void _launchFacebookPage() async {
    final Uri url = Uri.parse(
      "https://www.facebook.com/profile.php?id=100063606172658&mibextid=ZbWKwL",
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "لا يمكن فتح الرابط!";
    }
  }
}
