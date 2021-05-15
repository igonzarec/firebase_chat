import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    this.message,
    this.isMe,
    this.userName,
    this.key,
    this.userImage,
  });

  final String message;
  final bool isMe;
  final Key key;
  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Theme.of(context).accentColor : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Theme.of(context)
                            .accentTextTheme
                            .headline1
                            .color :
                        Colors.black)
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Theme.of(context)
                            .accentTextTheme
                            .headline1
                            .color
                            : Colors.black),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: isMe ? 120 : null,
          left: isMe ? null : 120,
          child: userImage != null ? CircleAvatar(backgroundImage: NetworkImage(userImage)) : Container(),
        ),
      ],
    );
  }
}
