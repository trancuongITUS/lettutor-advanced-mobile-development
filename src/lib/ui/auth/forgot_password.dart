import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:src/services/user_api.dart';
import 'package:src/ui/auth/signin_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isTypeEmail = true;
  String errorEmail = "";

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness:
                    Brightness.light,
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
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
                  ),
                ],
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100, right: 40, bottom: 0, left: 40),
          child: Column(
            children: [
              const Text("Reset Password",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Please enter your email address to search for your account.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 35,
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
                            isTypeEmail = false;
                            errorEmail = "Please input your Email!";
                          });
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          setState(() {
                            isTypeEmail = false;
                            errorEmail = "The input is not valid Email!";
                          });
                        } else {
                          setState(() {
                            isTypeEmail = true;
                          });
                        }
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: -15),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Visibility(
                      visible: !isTypeEmail,
                      child: Text(
                        errorEmail,
                        style: const TextStyle(color: Colors.red),
                      )),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: TextButton(
                        onPressed: () {
                          if (isTypeEmail && emailController.text != "") {
                            callApiResetPassword(emailController.text);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                          shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5),
                              ),
                          ),
                        ),
                        child: const Text(
                          "Reset password",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),

                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignIn()),
                          );
                        },
                        child: const Text(
                          "Go to Login?",
                          style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void callApiResetPassword(String emailReset) async {
    try {
      final userRepository = UserAPI();
      await userRepository.resetPassword(
          email: emailReset,
          result: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          });
    } finally {
    }
  }
}