import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_tech/View/theme/colors.dart';
import 'package:noviindus_tech/View/tools/commom_text_field.dart';
import 'package:noviindus_tech/View/tools/common_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/logo/logo.png'),
                  fit: BoxFit.cover,
                )),
                child: Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/logo/logo1.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Login Or Register to Book Your Appointments',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: 'Enter your email',
                      controller: emailController,
                      fieldText: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: 'Enter your password',
                      controller: passwordController,
                      isPassword: true,
                      fieldText: 'Password',
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CommonButton(
                        buttonText: 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, 'homePage');
                          }
                        }),
                    const SizedBox(
                      height: 120,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            'By creating or logging into an account you are agreeing with our ',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                                color: AppPalette.textBlueColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle Terms and Conditions tap
                              },
                          ),
                          const TextSpan(
                            text: ' and ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle Privacy Policy tap
                              },
                          ),
                          const TextSpan(
                            text: '.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
