import 'package:flutter/material.dart';
import 'package:trust_zone/utils/color_managers.dart';
import '../../../../core/localization/app_localizations.dart';
import '../widgets/events_body.dart';
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

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
          AppLocalizations.of(context).events,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorManager.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: const EventsBody(),
    );
  }
}
