import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final myTextFieldValue = TextEditingController();
  String userInput = 'Nothing to say';
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myTextFieldValue.dispose();
    super.dispose();
  }

  void clearText() {
    myTextFieldValue.clear();
  }

  onButtonClick(enteredText) {
    setState(() {
      userInput = enteredText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Task 1'), backgroundColor: Colors.purpleAccent),
            body: Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "What's in your head?",
                              hintText: 'Dump it hear! ;)',
                            ),
                            controller: myTextFieldValue)),
                    Padding(
                        padding: EdgeInsets.all(15), child: Text(userInput)),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Let us know'),
                      onPressed: () {
                        // debugPrint('data: $myTextFieldValue.text');
                        // userInput = myTextFieldValue.text;
                        onButtonClick(myTextFieldValue.text);
                        clearText();
                      },
                    )
                  ],
                ))));
  }
}
