import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:blacknoks/widgets/custom_checkbox.dart';
import '../models/theme.dart';

import '../services/auth_service.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  final FocusNode _emailFocusNode = FocusNode();
  Map<String, String>? _loginObject = Map<String, String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    'assets/images/Union2.png',
                    width: 500,
                    height: 100,
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        onSaved: (val) => _loginObject!['email'] = val!,
                        validator: (email) {
                          RegExp regex = RegExp(r'\w+@\w+\.\w+');
                          if (email!.isEmpty || !regex.hasMatch(email))
                            _emailFocusNode.requestFocus();
                          if (email.isEmpty)
                            return 'We need an email address';
                          else if (!regex.hasMatch(email))
                            // 3
                            return "That doesn't look like an email address";
                          else
                            // 4
                            return null;
                        },
                        autofocus: true,
                        focusNode: _emailFocusNode,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !passwordVisible,
                        validator: (pass1) {
                          RegExp hasUpper = RegExp(r'[A-Z]');
                          RegExp hasLower = RegExp(r'[a-z]');
                          RegExp hasDigit = RegExp(r'\d');
                          RegExp hasPunct = RegExp(r'[_!@#\$&*~-]');
                          if (!RegExp(r'.{8,}').hasMatch(pass1!))
                            return 'Passwords must have at least 8 characters';
                          if (!hasUpper.hasMatch(pass1))
                            return 'Passwords must have at least one uppercase character';
                          if (!hasLower.hasMatch(pass1))
                            return 'Passwords must have at least one lowercase character';
                          if (!hasDigit.hasMatch(pass1))
                            return 'Passwords must have at least one number';
                          if (!hasPunct.hasMatch(pass1))
                            return 'Passwords need at least one special character like !@#\$&*~-';
                          return null;
                        },
                        onSaved: (val) => _loginObject!['password'] = val!,
                        onChanged: (val) =>
                            setState(() => passwordController.text = val),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          hintStyle: heading6.copyWith(color: textGrey),
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: passwordConfirmationController,
                        obscureText: !passwordConfrimationVisible,
                        validator: (pass2) {
                          return (pass2 == passwordConfirmationController.text)
                              ? null
                              : "The two passwords must match";
                        },
                        decoration: InputDecoration(
                          hintText: 'Password Confirmation',
                          labelText: 'Password Confirmation',
                          hintStyle: heading6.copyWith(color: textGrey),
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(passwordConfrimationVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () {
                              setState(() {
                                passwordConfrimationVisible =
                                    !passwordConfrimationVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomCheckbox(),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'By creating an account, you agree to our',
                        style: regular16pt.copyWith(color: textGrey),
                      ),
                      Text(
                        'Terms & Conditions',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                    String? response =
                        await context.read<AuthenticationService>().signUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                    Flushbar(
                      isDismissible: true,
                      duration: const Duration(seconds: 2),
                      title: 'Sign Up',
                      message: response,
                    ).show(context);
                  },
                  child: const Text("Register"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: Text(
                      'Login',
                      style: regular16pt.copyWith(color: primaryBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
