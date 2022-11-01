import 'dart:math';

import 'package:chat_app/screen/chat_page.dart';
import 'package:chat_app/screen/register_page.dart';
import 'package:chat_app/widget/text_from_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widget/main_button.dart';
import '../widget/show_snak_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static String id = 'loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Form(
        key: formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 106),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 73,
                  ),
                  CustomTextFromFiled(
                      onChange: (data) {
                        email = data;
                      },
                      labelText: 'Email',
                      hintText: 'Plase Enter Your Eemail '),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFromFiled(
                      onChange: (data) {
                        password = data;
                      },
                      labelText: 'Password',
                      hintText: 'Plase Enter Your Password'),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MainButton(
                      text: 'Login',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoding = false;
                          setState(() {});
                          try {
                            await LoginUser();
                            Navigator.pushNamed(context, ChatPage.id,
                                arguments: email);
                            showSnakBar(context, 'Success');
                          } on FirebaseAuthException catch (ex) {
                            if (ex == 'user-not-found') {
                              showSnakBar(
                                  context, 'No user found for that email.');
                            } else if (ex == 'wrong-password') {
                              showSnakBar(context,
                                  'Wrong password provided for that user.');
                            }
                          } catch (ex) {
                            showSnakBar(context, 'error');
                          }
                          isLoding = true;
                          setState(() {});
                        }
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: const Text(
                        'Don\'t have an account? Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
