import 'package:firebase_provider_chatapp/thems/thmeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBuble extends StatelessWidget {
  final String message;
  final bool isCurentUser;
  const ChatBuble({super.key,required this.message,required this.isCurentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode=Provider.of<ThemeProvider>(context,listen: false).isDarkMod;
    return Container(
        decoration: BoxDecoration(
          color: isCurentUser ? Colors.green :Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12)
        ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 2.5,horizontal: 25),
      child: Text(message,style:const TextStyle(color: Colors.white),),
    );
  }
}
