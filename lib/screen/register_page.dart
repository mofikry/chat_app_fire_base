import 'package:chat_app/screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widget/main_button.dart';
import '../widget/show_snak_bar.dart';
import '../widget/text_from_field.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoding = false;

  GlobalKey<FormState> formKey = GlobalKey();

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
                    'Register',
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
                    hintText: 'Plase Enter Your Eemail ',
                  ),
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
                      child: Text(
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
                      text: 'Register',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoding = true;
                          setState(() {});
                          try {
                            await registerUser();
                            showSnakBar(context, 'Success');
                            Navigator.pop(context, LoginPage.id);
                          } on FirebaseAuthException catch (ex) {
                            if (ex == 'weak-password') {
                              showSnakBar(
                                  context, 'The password provided is to week');
                            } else if (ex == 'email-already-in-use') {
                              showSnakBar(context, 'Email Already In Use');
                            }
                          } catch (ex) {
                            showSnakBar(context, 'error');
                          }
                          isLoding = false;
                          setState(() {});
                        }
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
