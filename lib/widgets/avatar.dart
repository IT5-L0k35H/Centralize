
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key key, this.photoUrl, @required this.radius}) : super(key: key);
  final String photoUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black87,
          width: 0.0,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.deepOrange[100],
        backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
        child: photoUrl == null ? Icon(Icons.person, size: radius,color: Colors.indigo[600],) : null,
      ),
    );
  }
}
