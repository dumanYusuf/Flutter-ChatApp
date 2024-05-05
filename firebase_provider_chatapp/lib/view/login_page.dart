import 'package:firebase_provider_chatapp/complotes/myTextField.dart';
import 'package:firebase_provider_chatapp/view/register_page.dart';
import 'package:flutter/material.dart';

import '../servises/auth/firebase_servis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


TextEditingController _emailController=TextEditingController();
TextEditingController _passwordController=TextEditingController();


class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.message,size: 60,color: Theme.of(context).colorScheme.primary,),
            SizedBox(height: 50,),
            Text("Welcome bak my challenge",style: TextStyle(
                fontSize: 16,color: Theme.of(context).colorScheme.primary),),
            const SizedBox(height: 25,),
            MyTextField(hintText: "Email",obscureText: false,controller: _emailController,),
            MyTextField(hintText: "Login",obscureText: true,controller: _passwordController,),
            ElevatedButton(onPressed: (){
              login();
            }, child: Text("Login")),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a Member?",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
               const  SizedBox(width: 2),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterPage()));
                  },
                    child: const Text("Register Now"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
void login()async{
  final authServis=AuthServis();
  await authServis.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
}


