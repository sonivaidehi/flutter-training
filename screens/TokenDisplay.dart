

import 'package:flutter/material.dart';

import '../models/LoginRes.dart';

class TokenDisplay extends StatelessWidget {
  final LoginRes? res;

  TokenDisplay({required this.res});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //TODO: back press event
            Navigator.pop(context);
          },
        ),
        title: const Text('Logged In'),
      ),
      body: Center(
          child: Text(res?.token ?? "",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        ),
    );
  }
}

