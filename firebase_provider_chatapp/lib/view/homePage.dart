import 'package:firebase_provider_chatapp/complotes/myDrawer.dart';
import 'package:firebase_provider_chatapp/servises/auth/firebase_servis.dart';
import 'package:firebase_provider_chatapp/servises/chat/chatServis.dart';
import 'package:flutter/material.dart';

import '../complotes/UserTile.dart';
import 'chatPage.dart';


final ChatServis _chatServis=ChatServis();
final AuthServis _authServis=AuthServis();


class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
         appBar: AppBar(
           title: Text("Home"),
         actions: [
           IconButton(onPressed: (){
             signOut();
           }, icon:const  Icon(Icons.logout))
         ],
         ),
      body: _buildUserList(),
    );
  }

 Widget _buildUserList() {
    return StreamBuilder(
        stream:_chatServis.getUserStream(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text("Loading");
          }

          return ListView(
            children:snapshot.data!.map<Widget>((userdata)=>_buildUserListItem(userdata,context)).toList(),
          );
        });
 }
}

Widget _buildUserListItem(Map<String,dynamic>userdata,BuildContext context){
  if(userdata["email"] != _authServis.getCurentUser()!.email){
   return UserTile(
     text:userdata["email"],
     ontap: (){
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatPage(
         receiverEmail: userdata["email"],
         receiverId: userdata["uid"],
       )));
     },
   );
 }
 else{
   return Container();
 }

}

void signOut(){
  final auth=AuthServis();
  auth.signOut();
}
