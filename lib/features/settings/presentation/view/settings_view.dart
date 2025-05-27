import 'package:flutter/material.dart';
import 'package:trust_zone/utils/color_managers.dart';
import '../../../../core/localization/app_localizations.dart';
import '../widgets/setting_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(
          AppLocalizations.of(context).language,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading:BackButton(),
      ),
      body: const SettingsBody(),
    );
  }
}
