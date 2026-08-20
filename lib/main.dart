import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

import 'info.dart';
import 'marble_gallery_page.dart';
import 'construction_gallery_page.dart';
import 'locations_gallery_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Fadaly Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffF6F8F6),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  static const Color green = Color(0xff168044);
  static const Color darkGreen = Color(0xff0B542D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8F6),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // =====================================================
            // HEADER
            // =====================================================
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 25, 22, 35),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [darkGreen, green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),

                child: Column(
                  children: [
                    // =================================================
                    // LOGO
                    // =================================================
                    Container(
                      width: 110,
                      height: 110,
                      padding: const EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.20),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: ClipOval(
                        child: Image.asset(
                          'assets/logo.jpg',
                          fit: BoxFit.cover,

                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.business,
                              size: 55,
                              color: green,
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // COMPANY NAME
                    // =================================================
                    Text(
                      'EL FADALY',
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),

                    Text(
                      'FOR LANDSCAPING',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(.90),
                        letterSpacing: 3,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'معرض أعمال وخامات الشركة',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'استعرض أعمالنا وخامات الرخام ومشروعاتنا المختلفة',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        color: Colors.white.withOpacity(.85),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =====================================================
            // TITLE
            // =====================================================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 15),

                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 28,

                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      'استكشف المعرض',
                      style: GoogleFonts.cairo(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff222222),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =====================================================
            // GALLERY CARDS
            // =====================================================
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18),

              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // =================================================
                    // MARBLE
                    // =================================================
                    _GalleryCard(
                      title: 'خامات الرخام',
                      subtitle: 'Marble Materials',
                      icon: Icons.diamond_outlined,
                      color: const Color(0xff168044),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MarbleGalleryPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    // =================================================
                    // INSTALLATION
                    // =================================================
                    _GalleryCard(
                      title: 'طرق التركيب',
                      subtitle: 'Installation Methods',
                      icon: Icons.construction_outlined,
                      color: const Color(0xff8B5E34),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConstructionGalleryPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    // =================================================
                    // LOCATIONS
                    // =================================================
                    _GalleryCard(
                      title: 'المشروعات والمواقع',
                      subtitle: 'Projects & Locations',
                      icon: Icons.location_on_outlined,
                      color: const Color(0xff146C94),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LocationsGalleryPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // CONTACT
                    // =================================================
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Info()),
                        );
                      },

                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(color: green.withOpacity(.15)),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [
                            // Icon
                            Container(
                              width: 52,
                              height: 52,

                              decoration: BoxDecoration(
                                color: green.withOpacity(.10),
                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons.phone_in_talk_outlined,
                                color: green,
                              ),
                            ),

                            const SizedBox(width: 15),

                            // Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    'معلومات التواصل',
                                    style: GoogleFonts.cairo(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    'تواصل معنا لمعرفة المزيد',
                                    style: GoogleFonts.cairo(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // FOOTER
                    // =================================================
                    Text(
                      'El Fadaly For Landscaping',
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// GALLERY CARD
// ==================================================================

class _GalleryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _GalleryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 150,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),

          gradient: LinearGradient(
            colors: [color, color.withOpacity(.72)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.25),
              blurRadius: 15,
              offset: const Offset(0, 7),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),

          child: Stack(
            children: [
              // ======================================================
              // BACKGROUND DECORATION
              // ======================================================
              Positioned(
                right: -25,
                bottom: -35,

                child: Icon(
                  icon,
                  size: 150,
                  color: Colors.white.withOpacity(.08),
                ),
              ),

              // ======================================================
              // CARD CONTENT
              // ======================================================
              Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    // ==================================================
                    // ICON
                    // ==================================================
                    Container(
                      width: 62,
                      height: 62,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.95),
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.10),
                            blurRadius: 8,
                          ),
                        ],
                      ),

                      child: Icon(icon, color: color, size: 32),
                    ),

                    const SizedBox(width: 16),

                    // ==================================================
                    // TEXT
                    // ==================================================
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            title,

                            style: GoogleFonts.cairo(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            subtitle,

                            style: GoogleFonts.lato(
                              fontSize: 12,
                              color: Colors.white.withOpacity(.85),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ==================================================
                    // ARROW
                    // ==================================================
                    Container(
                      width: 38,
                      height: 38,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.18),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
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
  }
}
