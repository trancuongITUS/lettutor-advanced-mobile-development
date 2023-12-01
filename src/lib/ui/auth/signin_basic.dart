import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/main.dart';
import 'package:src/models/user.dart';

class SignInBasic extends StatefulWidget {
  final SignInCallback callback;

  const SignInBasic(this.callback, {super.key});

  @override
  State<SignInBasic> createState() => _SignInBasicState();
}

class _SignInBasicState extends State<SignInBasic> {
  bool isSignInSuccess = true;
  bool errorEmail = true;
  bool errorPassword = true;
  String errorMessage = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              onChanged: (value) {
                if ("" == value) {
                  setState(() {
                    errorEmail = false;
                    errorMessage = "Please input your Email";
                  });
                } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  setState(() {
                    errorEmail = false;
                    errorMessage = "The input is not valid Email!";
                  });
                } else {
                  setState(() {
                    errorEmail = true;
                  });
                }
              },
              controller: emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: -10),
                border: InputBorder.none,
              ),
              style:
                  const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
            ),
          ),
          Visibility(
            visible: !errorEmail,
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: const Text(
              "Password",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 40,
            padding:
                const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              onChanged: (value) {
                if (value == "") {
                  if (errorPassword == true) {
                    setState(() {
                      errorPassword = false;
                    });
                  }
                } else {
                  if (errorPassword == false) {
                    setState(() {
                      errorPassword = true;
                    });
                  }
                }
              },
              controller: passwordController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 1),
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.black54,
                  size: 20,
                ),
                border: InputBorder.none,
              ),
              obscureText: true,
              style:
                  const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
            ),
          ),
          Visibility(
              visible: !errorPassword,
              child: const Text(
                "Please input your Password!",
                style: TextStyle(color: Colors.red),
              )),
          Visibility(
            visible: !isSignInSuccess,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFfff2f0),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFffccc7),
                )
              ),
              child: const Row(
                children: [
                  Icon(Icons.highlight_remove_sharp,color: Colors.red,size: 18,),
                  SizedBox(width: 5,),
                  Text("Signin failed! Incorrect email or password.")
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              )),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5),
            child: TextButton(
                onPressed: () {
                  if(errorEmail && "" != emailController.text && "" != passwordController.text) {
                    if(emailController.text == user.email && passwordController.text == user.password)
                    {
                      setState(() {
                        isSignInSuccess = true;
                      });
                      widget.callback(1);
                    }
                    else{
                      setState(() {
                        isSignInSuccess = false;
                      });
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
