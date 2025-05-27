import 'package:flutter/material.dart';

import '../../../../../../core/localization/app_localizations.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: buildOutlinedInputBorder(),
        focusedBorder: buildOutlinedInputBorder(),
        filled: true,
        fillColor: const Color.fromARGB(255, 218, 214, 217),
        prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        hintText: AppLocalizations.of(context).search,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.filter_list_rounded, size: 30),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlinedInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffDADADA)),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
