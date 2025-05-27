import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/custom_back_button.dart';
import '../widget/build_contact_button.dart';


class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Center(
              child: Text(
                AppLocalizations.of(context).contactUs,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(height: 30),
            SizedBox(height: 16),
            ContactButton(
              icon: Icons.language,
              label:AppLocalizations.of(context).website,
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
              label:AppLocalizations.of(context).instagram,
              url: 'https://www.instagram.com/shimaa_rabeay22?utm_source=qr&igsh=Mm1mMnNvaG1zZ3pr',
            ),
          ],
        ),
      ),
    );
  }
}
