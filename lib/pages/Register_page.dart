import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Form(
              key: formKey,
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
                      Text("Register",
                          style: TextStyle(fontSize: 28, color: Colors.white)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: CustomFormTextField(
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: "Email"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: CustomFormTextField(
                           obscure:true,

                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Password'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CustomButton(
                        text: "Register",
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await registerUser();
                              Navigator.pushNamed(context, ChatPage.id);
                              showSnackBar(context, "Successful 😇 ");
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnackBar(context,
                                    "The password provided is too weak.");
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(
                                    context, "The account already exists.");
                              }
                            } catch (e) {
                              showSnackBar(context, "$e");
                            }
                            isLoading = false;
                            setState(() {});
                            ;
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Alraedy have an account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text("        Login",
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
    });
  }

  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
