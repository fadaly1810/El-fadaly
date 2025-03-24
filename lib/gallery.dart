import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:el_fadaly_gallery/build_dashboard_card.dart';
import 'package:el_fadaly_gallery/construction_gallery_page.dart';
import 'package:el_fadaly_gallery/info.dart';
import 'package:el_fadaly_gallery/locations_gallery_page.dart';
import 'package:el_fadaly_gallery/marble_gallery_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "El Fadaly For Landscaping",
                      style: GoogleFonts.lato(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.black.withValues(alpha: 0.2),
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "متخصصون في تصميم وتركيب الرخام للمنازل والمطابخ بجودة عالية.",
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        buildDashboardCard(
                          context: context,
                          title: "معلومات التواصل",
                          icon: Icons.contact_phone,
                          color: Colors.blue,
                          page: Info(),
                        ),
                        buildDashboardCard(
                          context: context,
                          title: "صور خامات الرخام",
                          icon: Icons.image,
                          color: Colors.green,
                          page: MarbleGalleryPage(),
                        ),
                        buildDashboardCard(
                          context: context,
                          title: "صور حسب طريقة التركيب",
                          icon: Icons.construction,
                          color: Colors.brown.shade700,
                          page: ConstructionGalleryPage(),
                        ),
                        buildDashboardCard(
                          context: context,
                          title: "صور حسب المواقع",
                          icon: Icons.location_on,
                          color: Colors.green.shade700,
                          page: LocationsGalleryPage(),
                        ),
                      ],
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
