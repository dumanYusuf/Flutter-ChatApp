import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider_chatapp/model/message.dart';
class ChatServis{

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Stream<List<Map<String,dynamic>>>getUserStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        final user=doc.data();
        return user;
      }).toList();
    });
  }


  //send message
  Future<void>sendMesage(String receiverId,String message)async{
    final String curentUserId=_auth.currentUser!.uid;
    final String curentUserEmail=_auth.currentUser!.email!;
    final Timestamp timestamp=Timestamp.now();

    // create new message
    
    Message mesaj=Message(
        senderId: curentUserId,
        senderEmail: curentUserEmail,
        receiverId: receiverId,
        timestamp: timestamp,
        messagee: message);

    List<String>ids=[curentUserId,receiverId];
    ids.sort();
    String chatRoomId=ids.join('_');
    await _firestore
    .collection("chat_rooms")
    .doc(chatRoomId)
    .collection("message")
    .add(mesaj.toMap());
  }

  //get message

  Stream<QuerySnapshot>getMessages(String userId,String otherUserId){
    List<String> ids=[userId,otherUserId];
    ids.sort();
    String chatRoomId=ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp",descending: false)
        .snapshots();
  }
}