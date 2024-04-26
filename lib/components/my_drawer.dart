import 'package:flutter/material.dart';

import '../pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      child: Column(
        children: [
          const DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 40,
                ),
              )),
          ListTile(
            title: const Text('H O M E'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('S E T T I N G S'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => SettingPage()
                  ),
              );
            },
          )
        ],
      ),
    );
  }
}
