import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trust_zone/utils/color_managers.dart';
import '../../../core/localization/app_localizations.dart';
import '../widget/build_contact_button.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).contactUs,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorManager.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            ContactButton(
              icon: Icons.language,
              label: AppLocalizations.of(context).website,
              url: 'https://yourwebsite.com',
            ),
            SizedBox(height: 12),
            ContactButton(
              icon: FontAwesomeIcons.facebookF,
              label: AppLocalizations.of(context).facebook,
              url: 'https://www.facebook.com/share/1YQnK6bb1m/',
            ),
            SizedBox(height: 12),
            ContactButton(
              icon: FontAwesomeIcons.twitter,
              label: AppLocalizations.of(context).twitter,
              url: 'https://x.com/shimaarabeay22?t=MHCFrx8lste829MNp9Hjlw&s=09',
            ),
            SizedBox(height: 12),
            ContactButton(
              icon: FontAwesomeIcons.instagram,
              label: AppLocalizations.of(context).instagram,
              url:
              'https://www.instagram.com/shimaa_rabeay22?utm_source=qr&igsh=Mm1mMnNvaG1zZ3pr',
            ),
          ],
        ),
      ),
    );
  }
}
