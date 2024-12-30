import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import '../Distributor.dart';

class SocialMediaScreen extends StatelessWidget {
  final Distributor distributor;

  const SocialMediaScreen({super.key, required this.distributor});

  @override
  Widget build(BuildContext context) {
    final socialMediaData = [
      {
        'name': 'Skype',
        'icon': 'assets/images/loading.svg',
        'color': Colors.blue
      },
      {
        'name': 'Facebook',
        'icon': 'assets/images/loading.svg',
        'color': Colors.blueAccent
      },
      {
        'name': 'Twitter',
        'icon': 'assets/images/loading.svg',
        'color': Colors.lightBlue
      },
      {
        'name': 'Linkedin',
        'icon': 'assets/images/loading.svg',
        'color': Colors.blue
      },
      {
        'name': 'Tiktok',
        'icon': 'assets/images/loading.svg',
        'color': Colors.black
      },
      {
        'name': 'Youtube',
        'icon': 'assets/images/loading.svg',
        'color': Colors.red
      },
      {
        'name': 'RssFeed',
        'icon': 'assets/images/loading.svg',
        'color': Colors.orange
      },
      {
        'name': 'Pinterest',
        'icon': 'assets/images/loading.svg',
        'color': Colors.redAccent
      },
      {
        'name': 'Instagram',
        'icon': 'assets/images/loading.svg',
        'color': Colors.pink
      },
      {
        'name': 'Whatsapp',
        'icon': 'assets/images/loading.svg',
        'color': Colors.green
      },
      {
        'name': 'Telegram',
        'icon': 'assets/images/loading.svg',
        'color': Colors.blue
      },
      {
        'name': 'Line',
        'icon': 'assets/images/loading.svg',
        'color': Colors.lightGreen
      },
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: socialMediaData.length,
        itemBuilder: (context, index) {
          final media = socialMediaData[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: media['color'] as Color,
              child: svgIcon(media['icon'] as String, color: Colors.white),
            ),
            title: Text(
              media['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('---'),
            trailing: IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                print(distributor.distributorWebsite); // Debug print
                Share.share(
                  'Website: ${distributor.distributorWebsite}',
                  subject: 'Distributor Website',
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget svgIcon(String assetPath, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      color: color,
      fit: BoxFit.contain,
    );
  }
}
