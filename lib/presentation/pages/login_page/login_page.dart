import 'dart:developer';

import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/domain/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool registerNow = false;
  bool isLoading = false;
  String textOfLogin = 'Login to continue';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //LOGIN TEXT

  //FOR CHECKING
  Future<void> signIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (registerNow) {
        log('Create ');
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } else {
        log('Login ');
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      }
      log('USER FOUND');
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
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
              // LOGO
              SizedBox(
                width: 144,
                height: 144,
                child: Image.asset(
                  'assets/logo/logo_white.png',
                  color: widgetColor,
                ),
              ),

              // SIGN IN
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  registerNow ? 'Create account' : 'Sign in',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),

              // LOGIN TO CONTINUE
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  textOfLogin,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: textOfLogin.substring(0, 1) == 'T'
                            ? widgetColor
                            : fontColor.withOpacity(0.8),
                      ),
                ),
              ),

              // EMAIL
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                      .hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: 'Email',
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

              const SizedBox(height: 20),

              // PASSWORD
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value.isNotEmpty && value.length < 6) {
                    return 'Min 6 character';
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

              //REGISTER NOW
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      registerNow = !registerNow;
                      textOfLogin = 'Register now';
                    });
                  },
                  child: Text(
                    registerNow ? 'Sign in' : 'Register now',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              // BUTTON
              Center(
                child: Container(
                  width: isLoading ? size.width / 3 : size.width / 1.8,
                  height: 48,
                  decoration: BoxDecoration(
                      color: widgetColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: widgetColor),

                    //ON PRESSED
                    onPressed: () async {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        await signIn();

                        if (context.mounted &&
                            FirebaseAuth.instance.currentUser != null) {
                          context
                              .read<UserBloc>()
                              .add(UserAuthenticatedEvent());
                        } else if (FirebaseAuth.instance.currentUser != null &&
                            !registerNow) {
                          setState(
                            () {
                              textOfLogin = 'There is no such user';
                            },
                          );
                        }
                      }
                    },

                    //
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: bgColor,
                              strokeWidth: 2,
                            )),
                          )
                        : Text(
                            registerNow ? 'REGISTER' : 'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
