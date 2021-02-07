import 'dart:ui';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => LoginScreen());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.message_outlined, size: screenHeight * 0.15),
          SizedBox(height: 10.0),
          Text(
            "Sign in",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 10.0),
          SignInContainer(
            screenWidth: screenWidth,
            icon: Icon(Icons.account_circle_rounded),
            text: Text("Continue with Google"),
            onTap: () {},
          ),
          SizedBox(height: 10.0),
          SignInContainer(
            screenWidth: screenWidth,
            icon: Icon(Icons.account_circle_rounded),
            text: Text("Continue with Facebook"),
            onTap: () {},
          ),
          SizedBox(height: 20.0),
          Text("or"),
          SizedBox(height: 20.0),
          SignInContainer(
            screenWidth: screenWidth,
            text: Text("Skip signing in"),
            icon: Icon(Icons.assignment_ind_rounded),
            color: Colors.red[100],
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class SignInContainer extends StatelessWidget {
  const SignInContainer({
    Key key,
    @required this.screenWidth,
    @required this.text,
    @required this.icon,
    @required this.onTap,
    this.color,
  }) : super(key: key);

  final double screenWidth;
  final Function onTap;
  final Icon icon;
  final Text text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Container(
        width: screenWidth * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: color != null ? color : Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          onTap: onTap,
          minVerticalPadding: 0.0,
          leading: icon,
          title: Center(child: text),
          isThreeLine: false,
        ),
      ),
    );
  }
}
