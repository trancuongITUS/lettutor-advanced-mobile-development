import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_basic.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                title: const Row(
                  children: [
                    Icon(
                      Icons.school,
                      size: 45,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: 7),
                    Text(
                      "LetTutor",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(top: 15, right: 15, bottom: 0, left: 15),
            child: Column(
              children: [
                Image.asset("img/img/login_bg.png"),
                const SizedBox(
                  height: 30,
                ),
                const Text("Say hello to your English tutors",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Become fluent faster through one on one video chat lessons tailored to your goals.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const LoginBasic(),
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: const Text("Or continue with")),
                const OrtherLogin()
              ],
            ),
          ),
        ));
  }
}

class OrtherLogin extends StatelessWidget {
  const OrtherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("img/fb.png", width: 30, height: 30),
              const SizedBox(
                width: 20,
              ),
              Image.asset("img/gg.png", width: 30, height: 30),
              const SizedBox(
                width: 20,
              ),
              Image.asset("img/phone.png", width: 30, height: 30),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, bottom: 50),
            child: RichText(
              text: TextSpan(
                text: 'Not a member yet? ',
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Sign up',
                      style: TextStyle(color: Colors.blueAccent)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
