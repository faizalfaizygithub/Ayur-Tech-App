import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_tech/Controller/provider/login_provider.dart';
import 'package:noviindus_tech/View/theme/colors.dart';
import 'package:noviindus_tech/View/tools/widgets/commom_text_field.dart';
import 'package:noviindus_tech/View/tools/widgets/common_button.dart';
import 'package:noviindus_tech/View/tools/widgets/common_loading_widget.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<LoginProvider>(builder: (context, value, child) {
        return LoadingWidget(
          isLoading: value.isLoading,
          child: SingleChildScrollView(
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
                      child: Image.asset(
                        'assets/logo/logo1.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Login or register to book your appointments',
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
                          height: 120,
                        ),
                        CommonButton(
                            buttonText: 'Login',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                value.login(
                                  context,
                                  username: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
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
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
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
                                style: const TextStyle(
                                    color: AppPalette.textBlueColor),
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
      }),
    );
  }
}
