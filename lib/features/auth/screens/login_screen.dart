import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/common/widgets/custom_button.dart';
import 'package:neighborgood/common/widgets/custom_check_box.dart';
import 'package:neighborgood/common/widgets/custom_text_field.dart';
import 'package:neighborgood/common/widgets/social_button.dart';
import 'package:neighborgood/features/auth/repository/auth_repository.dart';
import 'package:neighborgood/features/auth/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.read<AuthRepository>().loginUser(
            _emailController.text,
            _passwordController.text,
            context,
          );
    }
  }

  void loginWithGoogle(BuildContext context) async {
    context.read<AuthRepository>().signInWithGoogle(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logo.svg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let’s login for explore continues",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF000000).withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Email or Phone Number*',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email or Phone Number',
                    iconPath: 'assets/icons/email_box.svg',
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password*',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF000000),
                    ),
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    iconPath: 'assets/icons/password.svg',
                    isPassword: true,
                    prefixPath: 'assets/icons/eye.svg',
                    isObscure: true,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFFF6D00),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CustomCheckbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue ?? false;
                          });
                        },
                        activeColor: const Color(0xFFFF6D00),
                        size: 20.0,
                        borderRadius: 6.0,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Sign In',
                    onTap: () => login(context),
                    color: const Color(0xFFFF6D00),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xFFDDDDDD),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'You can connect with',
                            style: TextStyle(
                              color: const Color(0x00000000).withOpacity(
                                0.5,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xFFDDDDDD),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        iconPath: 'assets/icons/facebook.svg',
                        onTap: () {},
                      ),
                      SocialButton(
                        iconPath: 'assets/icons/google.svg',
                        onTap: () => loginWithGoogle(context),
                      ),
                      SocialButton(
                        iconPath: 'assets/icons/apple.svg',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          ' Sign up here',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFFF6D00),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
