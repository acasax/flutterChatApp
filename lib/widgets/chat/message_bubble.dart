import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessageBubble extends StatelessWidget {
  //const MessageBubble({Key key}) : super(key: key);
  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final String userImage;

  MessageBubble(this.message, this.isMe, this.username, this.userImage,
      {this.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.green : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 200,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: isMe
                          ? Colors.white
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.white
                          : Theme.of(context).accentTextTheme.headline1.color,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 180,
          right: isMe ? 180 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            radius: 20,
          ),
        ),
      ],
    );
  }
}
