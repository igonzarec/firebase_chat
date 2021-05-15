import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_practice/widgets/auth/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final chatDocs = chatSnapshot.data.documents;

            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) => MessageBubble(
                userImage: chatDocs[index]['userImage'],
                userName: chatDocs[index]['username'],
                message: chatDocs[index]['text'],
                isMe: chatDocs[index]['userId'] == futureSnapshot.data.uid,
                key: ValueKey(chatDocs[index].documentID),
              ),
            );
          },
        );
      },
    );
  }
}
