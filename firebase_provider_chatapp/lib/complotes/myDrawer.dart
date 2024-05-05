import 'package:firebase_provider_chatapp/view/SettingsPage.dart';
import 'package:flutter/material.dart';

import '../servises/auth/firebase_servis.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});

  final authServis=AuthServis();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(child: Center(
            child: Icon(Icons.message,size: 40,color: Theme.of(context).colorScheme.primary,),
          ),
          ),
          ListTile(
            title: Text("H O M E"),
            leading:const Icon(Icons.home),
            onTap: (){},
          ),
          ListTile(
            title: Text("S E T T I N G S"),
            leading:const  Icon(Icons.settings),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsPage()));
            },
          ),
          ListTile(
            title: const Text("L O G O U T"),
            leading: const Icon(Icons.logout),
            onTap: (){
              signOut();
            },
          )
        ],
      ),
    );
  }
}

void signOut(){
  final auth=AuthServis();
  auth.signOut();
}
