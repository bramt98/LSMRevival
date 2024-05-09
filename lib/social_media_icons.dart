import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Volg ons op onze kanalen',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton(
              icon: Icons.facebook,
              url: 'https://www.facebook.com/levendesteenministries',
            ),
            SizedBox(width: 40.0),
            SocialMediaButton(
              icon: Icons.public,
              url: 'https://levendesteenministries.nl',
            ),
            SizedBox(width: 40.0),
            SocialMediaButton(
              icon: Icons.info,
              url: 'https://www.instagram.com/levendesteenroermond?igsh=MW5ia2F2N3RucWRwbQ==',
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Created and developed by: Cor-iT',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String url;

  SocialMediaButton({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 40.0),
      onPressed: () async {
        if (await canLaunch(url)) {
          try {
            await launch(url);
          } catch (e) {
            // Handle error here
          }
        } else {
          // Handle error here
        }
      },
    );
  }
}