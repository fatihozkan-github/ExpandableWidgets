import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'anim',
        child: Container(
          height: 40,
          width: 40,
          color: Colors.blue,
        ),
      ),
    );
  }
}
