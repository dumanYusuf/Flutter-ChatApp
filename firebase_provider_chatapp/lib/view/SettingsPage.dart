
import 'package:firebase_provider_chatapp/thems/thmeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Dark Mode"),
          CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context,listen: false).isDarkMod,
              onChanged:(value)=>Provider.of<ThemeProvider>(context,listen: false).toogleTheme())
        ],
      ),
    );
  }
}
