import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return StreamBuilder(
      stream: firestore.collection('chat').snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
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
          itemCount: documents.length,
          itemBuilder: (context, index) => Text(
            documents[index]['text'],
          ),
        );
      },
    );
  }
}
