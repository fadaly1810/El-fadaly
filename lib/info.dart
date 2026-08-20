import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  static const Color green = Color(0xff168044);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8F6),

      appBar: AppBar(
        backgroundColor: green,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'تواصل معنا',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(25),

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(.07),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                children: [

                  Container(
                    width: 120,
                    height: 120,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: green,
                        width: 3,
                      ),
                    ),

                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    'El Fadaly For Landscaping',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: green,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'متخصصون في أعمال اللاندسكيب والرخام',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _InfoTile(
                    icon: Icons.location_on,
                    color: Colors.red,
                    title: 'العنوان',
                    value:
                        'الشيخ زايد - محور المهندس شريف إسماعيل',
                  ),

                  const SizedBox(height: 10),

                  _InfoTile(
                    icon: Icons.business,
                    color: Colors.brown,
                    title: 'صاحب الشركة',
                    value: 'م/ شعبان محمد فضالي',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            _PhoneCard(
              name: 'م/ شعبان محمد',
              phone: '01229007512',
            ),

            _PhoneCard(
              name: 'م/ محمد شعبان',
              phone: '01099657323',
            ),

            _PhoneCard(
              name: 'م/ يوسف شعبان',
              phone: '01090438638',
            ),

            _PhoneCard(
              name: 'م/ احمد شعبان',
              phone: '01156634220',
            ),

            const SizedBox(height: 15),

            _ActionCard(
              icon: Icons.email_outlined,
              color: Colors.orange,
              title: 'البريد الإلكتروني',
              subtitle: 'Shaban.fadaly@yahoo.com',
              onTap: () => _sendEmail(
                'Shaban.fadaly@yahoo.com',
              ),
            ),

            const SizedBox(height: 10),

            _ActionCard(
              icon: FontAwesomeIcons.facebook,
              color: Colors.blue,
              title: 'Facebook',
              subtitle: 'صفحة El Fadaly For Landscaping',
              onTap: _launchFacebookPage,
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _sendEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> _launchFacebookPage() async {
    final uri = Uri.parse(
      'https://www.facebook.com/profile.php?id=100063606172658',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}

// ======================================================

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius:
            BorderRadius.circular(15),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: color,
            size: 28,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================

class _PhoneCard extends StatelessWidget {
  final String name;
  final String phone;

  const _PhoneCard({
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(.05),
            blurRadius: 10,
          ),
        ],
      ),

      child: ListTile(

        leading: Container(
          width: 45,
          height: 45,

          decoration: BoxDecoration(
            color: const Color(
              0xff168044,
            ).withOpacity(.10),
            shape: BoxShape.circle,
          ),

          child: const Icon(
            Icons.person,
            color: Color(0xff168044),
          ),
        ),

        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(phone),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              onPressed: () => _call(phone),
              icon: const FaIcon(
                FontAwesomeIcons.phone,
                color: Colors.blue,
                size: 18,
              ),
            ),

            IconButton(
              onPressed: () => _whatsapp(phone),
              icon: const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.green,
                size: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _call(String phone) async {
    final uri = Uri.parse('tel:$phone');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> _whatsapp(String phone) async {

    final number = '20${phone.substring(1)}';

    final uri = Uri.parse(
      'https://wa.me/$number',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}

// ======================================================

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(.05),
              blurRadius: 10,
            ),
          ],
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: color,
              size: 30,
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}