import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/presentation/business_logic/cubit/user/user_cubit.dart';
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
    SocialMedia(
      name: "twitter".tr,
      icon: Icons.campaign,
      url: "https://twitter.com",
      color: Color(0xFF000000),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppBar("about".tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info Card
            MyCard(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColor.kPrimaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 40,
                      color: AppColor.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Shopping App",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Version 1.0.0",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "The best shopping experience with thousands of products at your fingertips.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Social Media Section
            Text(
              "connect_with_us".tr,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...socialMediaList.map((social) => _buildSocialMediaCard(social)),

            // Contact Info Section
            const SizedBox(height: 24),
            Text(
              "contact_info".tr,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            MyCard(
              child: Column(
                children: [
                  _buildContactItem(
                    icon: Icons.email,
                    title: "Email",
                    value: "support@shoppingapp.com",
                    onTap: () => _launchUrl("mailto:support@shoppingapp.com"),
                  ),
                  const Divider(),
                  _buildContactItem(
                    icon: Icons.phone,
                    title: "Phone",
                    value: "+1 (123) 456-7890",
                    onTap: () => _launchUrl("tel:+11234567890"),
                  ),
                  const Divider(),
                  _buildContactItem(
                    icon: Icons.location_on,
                    title: "Address",
                    value: "123 Main St, City, Country",
                    onTap: () => _launchUrl("https://maps.google.com"),
                  ),
                ],
              ),
            ),

            // App Info Footer
            const SizedBox(height: 24),
            Center(
              child: Text(
                "© 2023 Shopping App. All rights reserved.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard(SocialMedia social) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MyCard(
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
          title: Text(
            social.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
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

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.kPrimaryColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
