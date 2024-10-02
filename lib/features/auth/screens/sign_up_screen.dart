import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/common/utils/show_snackbar.dart';
import 'package:neighborgood/common/widgets/custom_button.dart';
import 'package:neighborgood/common/widgets/custom_check_box.dart';
import 'package:neighborgood/common/widgets/custom_text_field.dart';
import 'package:neighborgood/common/widgets/social_button.dart';
import 'package:neighborgood/features/auth/repository/auth_repository.dart';
import 'package:neighborgood/features/auth/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isChecked = false;
  final formKey = GlobalKey<FormState>();

  void register() async {
    print('hi');
    if (_passwordController.text == _confirmPasswordController.text) {
      context.read<AuthRepository>().registerUser(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
            name: _fullNameController.text,
          );
    } else {
      showSnackBar(
        context,
        "Password doesn't match",
        'Error',
      );
    }
  }

  void loginWithGoogle(BuildContext context) async {
    context.read<AuthRepository>().signInWithGoogle(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Full Name*',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  CustomTextField(
                    controller: _fullNameController,
                    hintText: 'Enter your full name',
                    iconPath: '',
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  const Text(
                    'Confirm password*',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF000000),
                    ),
                  ),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Re-enter your password',
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
                        'I agree to terms & conditions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Create Account',
                    onTap: register,
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          ' Login',
                          style: TextStyle(
                            fontSize: 15,
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
