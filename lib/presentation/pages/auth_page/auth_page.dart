import 'dart:developer';

import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/presentation/checking_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      log('USER CREATED');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width / 12,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 
                L O G O
              */
              SizedBox(
                width: 144,
                height: 144,
                child: Image.asset(
                  'assets/logo/logo_white.png',
                  color: widgetColor,
                ),
              ),

              //CREATE ACCOUNT
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Create account',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),

              //REGISTER TO CONTINUE
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Register to continue',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: fontColor.withOpacity(0.8),
                      ),
                ),
              ),
              /*
                TEXT FORM FIELD
              */
              //EMAIL
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: 'Login',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        color: fontColor.withOpacity(0.6),
                      ),
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.2),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.2),
                  ),
                ),
              ),

              //SIZED BOX
              const SizedBox(
                height: 20,
              ),

              //PASSWORD
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        color: fontColor.withOpacity(0.6),
                      ),
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.2),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.2),
                  ),
                ),
              ),

              //SIZED BOX
              const SizedBox(
                height: 52,
              ),

              //REGISTER BUTTON
              Center(
                child: Container(
                  width: size.width / 1.8,
                  height: 48,
                  decoration: BoxDecoration(
                      color: widgetColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: widgetColor),
                    onPressed: () async {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        log('if');
                        await signUp();
                        if (mounted &&
                            FirebaseAuth.instance.currentUser != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const CheckingScreen(),
                            ),
                          );
                        }
                      } else {
                        null;
                      }
                    },
                    child: Text(
                      'REGISTER',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )

              //
            ],
          ),
        ),
      ),
    );
  }
}
