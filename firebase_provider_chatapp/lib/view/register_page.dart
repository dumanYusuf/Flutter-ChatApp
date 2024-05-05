import 'package:firebase_provider_chatapp/complotes/myTextField.dart';
import 'package:firebase_provider_chatapp/view/homePage.dart';
import 'package:firebase_provider_chatapp/view/login_page.dart';
import 'package:flutter/material.dart';

import '../servises/auth/firebase_servis.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}


TextEditingController _emailController=TextEditingController();
TextEditingController _passwordController=TextEditingController();
TextEditingController _confirmPasswordController=TextEditingController();



class _RegisterPageState extends State<RegisterPage> {
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
            MyTextField(hintText: "Confirm Password", obscureText: true, controller: _confirmPasswordController),
            ElevatedButton(onPressed: (){
              register();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
            }, child: Text("Register")),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("AllReady have an account?",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                const  SizedBox(width: 5),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                    child: const Text("Login Now"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

void register(){
  final _auth=AuthServis();
  if(_passwordController.text==_confirmPasswordController.text){
    try{
      _auth.signUpWithEmailAndPassword(_emailController.text, _passwordController.text);
    }
    catch(e){
      print("hata cıktı $e");
  }
  }
}
