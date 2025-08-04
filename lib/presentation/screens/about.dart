import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  About({super.key});
  static String id = "about";

  final List<SocialMedia> socialMediaList = [
    SocialMedia(
      name: "facebook".tr,
      icon: Icons.facebook,
      url: "https://facebook.com",
      color: Color(0xFF1877F2),
    ),
    SocialMedia(
      name: "whatsapp".tr,
      icon: Icons.face,
      url: "https://wa.me/",
      color: Color(0xFF25D366),
    ),
    SocialMedia(
      name: "youtube".tr,
      icon: Icons.youtube_searched_for,
      url: "https://youtube.com",
      color: Color(0xFFFF0000),
    ),
    SocialMedia(
      name: "telegram".tr,
      icon: Icons.telegram,
      url: "https://t.me/",
      color: Color(0xFF0088CC),
    ),
    SocialMedia(
      name: "instagram".tr,
      icon: Icons.face,
      url: "https://instagram.com",
      color: const Color(0xFFE4405F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppBar(title: "about".tr, context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info Card

            // Social Media Section
            CairoText(
              "connect_with_us".tr,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...socialMediaList.map((social) => _buildSocialMediaCard(social)),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard(SocialMedia social) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MyCard(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        onTap: () => _launchUrl(social.url),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: social.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              social.icon,
              color: social.color,
            ),
          ),
          title: CairoText(
            social.name,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class SocialMedia {
  final String name;
  final IconData icon;
  final String url;
  final Color color;

  const SocialMedia({
    required this.name,
    required this.icon,
    required this.url,
    required this.color,
  });
}
