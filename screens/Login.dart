import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task4/DioClient.dart';
import 'package:task4/models/LoginReq.dart';
import 'package:task4/models/LoginRes.dart';
import 'package:task4/screens/TokenDisplay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailValue = TextEditingController();
  bool _invalidEmail = false;
  final passwordValue = TextEditingController();
  bool _invalidPassword = false;
  LoginRes? temp;
  DioClient apiCall = DioClient();

  _clear() {
    emailValue.clear();
    passwordValue.clear();
  }

  _onLoginPressed(BuildContext context) async {
    LoginReq req = LoginReq();
    req.email = emailValue.text;
    req.password = passwordValue.text;
    temp = await apiCall.loginUser(req: req);
    if (temp?.token != null) {
      return temp;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border:const OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Email',
                    errorText: _invalidEmail ? 'Email required!' : null,
                  ),
                  controller: emailValue,
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                      errorText: _invalidPassword ? 'Password required!' : null
                  ),
                  controller: passwordValue,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Colors.green)),
                      onPressed: () async {
                        setState(() {
                          emailValue.text.isEmpty ? _invalidEmail = true : _invalidEmail = false;
                          passwordValue.text.isEmpty ? _invalidPassword = true : _invalidPassword = false;
                        });
                        if(!_invalidEmail && !_invalidPassword){
                          temp = await _onLoginPressed(context);
                          if (temp != null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    TokenDisplay(res: temp)));
                            _clear();
                          } else {
                            showAlertDialog(context);
                          }
                        }
                      },
                      child: const Text('Log In'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.redAccent)),
                      onPressed: () {
                        _clear();
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Oops!"),
      content: const Text("Invalid Credentials!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
