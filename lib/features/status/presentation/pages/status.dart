import 'package:flutter/material.dart';
import 'package:whatsapp/core/theme/colors.dart';

class Status extends StatelessWidget {
  static const String routeName = '/status';

  const Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('status'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 45,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
        const  SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            elevation: 5,
            child: const Icon(Icons.camera_alt),
          )
        ],
      ),
    );
  }
}
