import 'package:flutter/material.dart';
class Groups extends StatelessWidget {
  static const routeName='/groups';
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('groups'),
      ),
    );
  }
}
