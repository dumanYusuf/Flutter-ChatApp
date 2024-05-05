import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_provider_chatapp/complotes/chat_buble.dart';
import 'package:firebase_provider_chatapp/complotes/myTextField.dart';
import 'package:firebase_provider_chatapp/servises/auth/firebase_servis.dart';
import 'package:firebase_provider_chatapp/servises/chat/chatServis.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;

  ChatPage({super.key,required this.receiverEmail,required this.receiverId});

  final TextEditingController _mesasageControler=TextEditingController();

  final ChatServis _chatServis=ChatServis();
  final AuthServis _authServis=AuthServis();

  void sendMessage()async{
    if(_mesasageControler.text.isNotEmpty){
      await _chatServis.sendMesage(receiverId, _mesasageControler.text);

      _mesasageControler.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail),),
       body: Column(
         children: [
           Expanded(child: _buildMessageList()),
           _buildUserInput()
         ],
       ),
    );
  }

 Widget _buildMessageList() {
    String senderId=_authServis.getCurentUser()!.uid;
    return StreamBuilder(
        stream: _chatServis.getMessages(receiverId, senderId),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Text("Eror");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        });
  }

 Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String,dynamic>data=doc.data() as Map<String,dynamic>;

    bool iscurentUser=data["senderId"]==_authServis.getCurentUser()!.uid;
    var aligment=iscurentUser ? Alignment.centerRight :Alignment.centerLeft;

    return  Column(
      crossAxisAlignment: iscurentUser ? CrossAxisAlignment.end :CrossAxisAlignment.start,
      children: [
        Container(alignment:aligment,child: Text(data["message"])),
        ChatBuble(message: data["message"], isCurentUser: iscurentUser)
      ],
    );
 }

 Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
            Expanded(child: MyTextField(
                hintText: "my type message",
                obscureText: false,
                controller: _mesasageControler),
            ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            child: IconButton(
                onPressed: sendMessage,
                icon:const  Icon(Icons.arrow_upward,color: Colors.white,)),
          )
        ],
      ),
    );
 }
}



