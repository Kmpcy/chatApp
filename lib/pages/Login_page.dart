import 'package:chat_app_sholar/widgets/custom_button.dart';
import 'package:chat_app_sholar/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snackbar.dart';
import 'Register_page.dart';
import 'chat_page.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Spacer(flex: 1),
                Image.asset("assets/images/scholar.png"),
                Text("Sholar Chat",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Pacifico",
                        color: Colors.white)),
                Spacer(flex: 1),
                Row(
                  children: [
                    Text("Login",
                        style: TextStyle(fontSize: 28, color: Colors.white)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: CustomFormTextField(
                      hintText: "Email",
                      onChanged: (data) {
                        email = data;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomFormTextField(
                    obscure:true,
                    hintText: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: (CustomButton(
                      text: "Login",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          {
                            try {
                              await UserSignIn();
                              Navigator.pushNamed(context, ChatPage.id,arguments:email);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showSnackBar(context, 'user-not-found');
                              } else if (e.code == 'wrong-password') {
                                showSnackBar(context,
                                    'Wrong password provided for that user.');
                              }
                            } catch (e) {
                              //print("please Register an account");
                              showSnackBar(context, "$e");
                            }
                            isLoading = false;
                            setState(() {});
                            ;
                          }
                        }
                      })),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: Text("       Register",
                                style: TextStyle(
                                    color: Color(0xffC7EDE6), fontSize: 18)))
                      ]),
                ),
                Spacer(flex: 4)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> UserSignIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
