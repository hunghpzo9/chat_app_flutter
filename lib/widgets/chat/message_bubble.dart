import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key key;
  MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {required this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color:
                    !isMe ? Colors.grey[300] : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).textTheme.headline1!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -3,
          left: isMe ? null : 125,
          right: isMe ? 125 : null,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(userImage),
            ),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
