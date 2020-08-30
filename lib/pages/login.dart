import 'package:flutter/material.dart';
import 'package:game_tv/pages/profile.dart';
import 'package:game_tv/utils/AuthHandler.dart';
import 'package:game_tv/utils/LoginController.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController loginController = LoginController();
  final AuthHandler authHandler = AuthHandler();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode userFocusNode;
  FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/logo.png',
                      width: 200,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: TextFormField(
                        focusNode: userFocusNode,
                        controller: loginController.usernameController,
                        validator: (value) {
                          if (value.length < 3 || value.length > 10) {
                            return 'Username can have 3 to 10 characters';
                          }
                          return null;
                        },
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          helperText: "",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(32)),
                        ),
                        style: TextStyle(color: Colors.white),
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: TextFormField(
                          focusNode: passwordFocusNode,
                          controller: loginController.passwordController,
                          validator: (value) {
                            if (value.length < 3 || value.length > 11) {
                              return 'Password can have 3 to 11 characters';
                            }
                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            helperText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32)),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(32)),
                          ),
                          style: TextStyle(color: Colors.white))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: RaisedButton(
                      textColor: Colors.black,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      padding: EdgeInsets.fromLTRB(48.0, 16.0, 48.0, 16.0),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          authHandler
                              .login(loginController.usernameController.text,
                                  loginController.passwordController.text)
                              .then((value) => {
                                    if (value)
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Profile()),
                                      )
                                    else
                                      _showSnackBar(
                                          "Incorrect Username or Password")
                                  });
                        }
                      },
                      child: Text('LOGIN'),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            )));
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Padding(
          padding: EdgeInsets.all(4),
          child: Text(text),
        )));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    loginController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    userFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        setState(() {
          _formKey.currentState.validate();
        });
      }
    });
    userFocusNode.addListener(() {
      if (!userFocusNode.hasFocus) {
        setState(() {
          _formKey.currentState.validate();
        });
      }
    });
  }
}
