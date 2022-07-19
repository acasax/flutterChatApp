import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    bool isLoading = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemsIdentifier) {
              if (itemsIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      // body: StreamBuilder(
      //   stream: firestore
      //       .collection('chats')
      //       .doc('bAdVETxDpMo1uFNgCP2n')
      //       .collection('messages')
      //       .snapshots(),
      //   builder: (BuildContext context,
      //       AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      //     if (streamSnapshot.hasError) {
      //       return Text('Something went wrong');
      //     }

      //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     final documents = streamSnapshot.data.docs;
      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (ctx, index) => Container(
      //         padding: EdgeInsets.all(10),
      //         child: Text(
      //           documents[index]['text'],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     firestore
      //         .collection('chats')
      //         .doc('bAdVETxDpMo1uFNgCP2n')
      //         .collection('messages')
      //         .add({'text': 'This is add +'});
      //   },
      // ),
    );
  }
}
