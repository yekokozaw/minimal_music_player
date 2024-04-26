import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S E T T I N G S'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Dark Mode",
              style: TextStyle(fontWeight: FontWeight.bold),),
            
            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
                onChanged: (value)=> Provider.of<ThemeProvider>(context,listen: false).toggleTheme()
            )
          ],
        ),
      ),
    );
  }
}
