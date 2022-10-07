import 'package:flutter/material.dart';
class Status extends StatelessWidget {
  static const String routeName='/status';
  const Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('status'),
      ),
    );
  }
}
