import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[700],
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.jpg', height: 100),
                  SizedBox(height: 10),

                  Text(
                    "El Fadaly For Landscaping",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),

                  SizedBox(height: 10),
                  Divider(thickness: 1, color: Colors.green[800]),

                  _buildInfoRow(
                    Icons.location_on,
                    "الشيخ زايد - محور المهندس شريف إسماعيل",
                    Colors.red,
                  ),

                  Divider(thickness: 1, color: Colors.green[800]),

                  _buildInfoRow(
                    Icons.business,
                    subtitle1: "صاحب الشركة",
                    "👤 م/ شعبان محمد فضالي",
                    Colors.brown,
                  ),
                  Divider(thickness: 1, color: Colors.green[800]),

                  _buildPhoneRow("م/ شعبان محمد", "01229007512"),

                  _buildPhoneRow("م/ محمد شعبان", "01099657323"),
                  _buildPhoneRow("م/ يوسف شعبان", "01090438638"),
                  _buildPhoneRow("م/ احمد شعبان", "01156634220"),

                  Divider(thickness: 1, color: Colors.green[800]),

                  _buildClickableRow(
                    Icons.email,
                    "Shaban.fadaly@yahoo.com",
                    Colors.orange,
                    () => _sendEmail("shaban.fadaly@yahoo.com"),
                  ),

                  Divider(thickness: 1, color: Colors.green[800]),

                  _buildClickableRow(
                    Icons.facebook,
                    "صفحة الفيسبوك",
                    Colors.blue,
                    _launchFacebookPage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String text,
    Color iconColor, {
    String? subtitle1,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text, style: TextStyle(fontSize: 18)),
      subtitle:
          subtitle1 != null && subtitle1.isNotEmpty
              ? Text(subtitle1, style: TextStyle(fontSize: 16))
              : null,
    );
  }

  Widget _buildPhoneRow(String name, String phoneNumber) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.green[700]),
        title: Text(
          "$name: $phoneNumber",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.phone, color: Colors.blue),
              onPressed: () => _makePhoneCall(phoneNumber),
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
              onPressed: () => _openWhatsApp(phoneNumber),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableRow(
    IconData icon,
    String text,
    Color iconColor,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
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

  void _openWhatsApp(String phoneNumber) async {
    final Uri url = Uri.parse("https://wa.me/+2$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "لا يمكن فتح تطبيق واتساب!";
    }
  }

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
