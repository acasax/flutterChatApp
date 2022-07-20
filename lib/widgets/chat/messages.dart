import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.hasError) {
          return Text('Something went wrong');
        }

        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: firestore
              .collection('chat')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder:
              (BuildContext ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
            if (chatSnapshot.hasError) {
              return Text('Something went wrong');
            }

            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final documents = chatSnapshot.data.docs;

            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (context, index) => MessageBubble(
                documents[index]['text'],
                documents[index]['userId'] == futureSnapshot.data.uid,
                documents[index]['username'] == null
                    ? ''
                    : documents[index]['username'],
                documents[index]['userImage'],
                key: ValueKey(
                  documents[index].id,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
