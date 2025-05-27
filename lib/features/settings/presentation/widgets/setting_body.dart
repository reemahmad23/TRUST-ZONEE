import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/locale_cubit.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  DropdownMenuItem<Locale> languageDropdownItem(
      Locale locale, String text, String flagEmoji) {
    return DropdownMenuItem<Locale>(
      value: locale,
      child: Row(
        children: [
          Text(
            flagEmoji,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeCubit = BlocProvider.of<LocaleCubit>(context);
    final currentLocale = localeCubit.state;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language, color: Colors.blue),
            title: Text(
              AppLocalizations.of(context).language,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade300),
              ),
              child: DropdownButton<Locale>(
                value: currentLocale,
                underline: const SizedBox(),
                iconEnabledColor: Colors.blue,
                items: [
                  languageDropdownItem(
                      const Locale('en'),
                      AppLocalizations.of(context).english,
                      '🇺🇸'),
                  languageDropdownItem(
                      const Locale('ar'),
                      AppLocalizations.of(context).arabic,
                      '🇸🇦'),
                ],
                onChanged: (locale) {
                  if (locale != null) {
                    localeCubit.setLocale(locale);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
