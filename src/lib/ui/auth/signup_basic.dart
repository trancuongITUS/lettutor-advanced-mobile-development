import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/models/user.dart';
import 'package:src/provider/authentication_provider.dart';

class SignUpBasic extends StatefulWidget {
  const SignUpBasic({super.key});

  @override
  State<SignUpBasic> createState() => _SignUpBasicState();
}

class _SignUpBasicState extends State<SignUpBasic> {
  bool requiredEmail = true;
  bool requiredPassword = true;
  String errorMessage = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                if (value == "") {
                  setState(() {
                    requiredEmail = false;
                    errorMessage = "Please input your Email!";
                  });
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  setState(() {
                    requiredEmail = false;
                    errorMessage = "The input is not valid Email!";
                  });
                } else {
                  setState(() {
                    requiredEmail = true;
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
              visible: !requiredEmail,
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              )),
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
            padding: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
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
                  if (requiredPassword == true) {
                    setState(() {
                      requiredPassword = false;
                    });
                  }
                } else {
                  if (requiredPassword == false) {
                    setState(() {
                      requiredPassword = true;
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
              visible: !requiredPassword,
              child: const Text(
                "Please input your Password!",
                style: TextStyle(color: Colors.red),
              )),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            child: TextButton(
                onPressed: () async {
                  if (emailController.text.isNotEmpty && requiredEmail && passwordController.text.isNotEmpty) {
                    var authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
                    try {
                      await authenticationProvider.authenticationAPI.signUpByAccount(
                        email: emailController.text,
                        password: passwordController.text,
                        onSuccess: () {
                          Navigator.pop(context, true);
                        },
                        onFail: (String error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${error.toString()}'))
                          );
                        }
                      );
                    // ignore: empty_catches
                    } catch (err) {
                      
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
                  "SIGN UP",
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