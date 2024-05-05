import 'package:firebase_provider_chatapp/view/login_page.dart';
import 'package:firebase_provider_chatapp/view/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  bool showLoginPage=true;

  void toglePages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
}

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage();
    }
    else{
      return RegisterPage(
      );
    }
  }
}
