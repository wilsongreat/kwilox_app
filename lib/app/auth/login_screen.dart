import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwilox/app/auth/signup_screen.dart';
import 'package:kwilox/app/pages/display_page.dart';

import '../../../widgets/my_button.dart';
import '../../../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userPassword = '';

  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _trySumbit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      await _submitAuthForm(_userEmail.trim(), _userPassword.trim(), context);
      print('Successful login');
    }
  }

  Future<void> _submitAuthForm(
      String email, String password, BuildContext ctx) async {
    UserCredential authResult;
    try {
      // Login
      authResult = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      setState(() {
        _isLoading = true;
      });
      print('Log in successful');

      print('Successful login');
    } on PlatformException catch (e) {
      var message = 'An error occured ,please check your credentials';
      if (e.message != null) {
        message = e.message!;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }
  // nav() {
  //   Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
  // // }
  // validateEmail(value) {
  //
  //
  // validatePassword(value) {
  //   if (value.isEmpty || value.length < 7) {
  //     return 'Please enter a valid email address';
  //   }
  //   returif (value.isEmpty ||
  //   //       !value.contains('@') ||
  //   //       !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2-4}').hasMatch(value)) {
  //   //     return 'Please enter a valid email address';
  //   //   }
  //   //   return null;
  //   // }n null;
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: FadeInDown(
              duration: Duration(milliseconds: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height / 7,
                  ),
                  Text(
                    'Welcome back!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Sign in to your account to get access',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Container(
                        height: size.height / 1.6,
                        child: Column(
                          children: [
                            InputField(
                              validator: (value) {
                                // if (value.isEmpty ||
                                //     !value.contains('@') ||
                                //     !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2-4}')
                                //         .hasMatch(value)) {
                                //   return 'Please enter a valid email address';
                                // }
                                // return null;
                              },
                              inputController: emailController,
                              isPassword: false,
                              hasSuffixIcon: false,
                              hintText: 'Email Address',
                              prefixIcon: Image.asset(
                                'assets/Icon_email.png',
                                color: Color(0xFF333333).withOpacity(0.8),
                              ),
                              onSaved: (value) {
                                _userPassword = value;
                              },
                              keyBoardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            InputField(
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              inputController: passwordController,
                              hasSuffixIcon: true,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              hintText: 'Password',
                              prefixIcon: Image.asset(
                                'assets/Icon_password.png',
                              ),
                              onSaved: (value) {
                                _userPassword = value;
                              },
                              keyBoardType: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            MyButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  // await _auth
                                  //     .signInWithEmailAndPassword(
                                  //         email: emailController.text.trim(),
                                  //         password:
                                  //             passwordController.text.trim())
                                  //     .then((value) => Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (_) => HomeScreen())));

                                  try {
                                    // Login
                                    await _auth
                                        .signInWithEmailAndPassword(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim())
                                        .then((value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    DisplayDrinksPage())));
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    print('Log in successful');

                                    print('Successful login');
                                  } on PlatformException catch (e) {
                                    var message =
                                        'An error occured ,please check your credentials';
                                    if (e.message != null) {
                                      message = e.message!;
                                    }
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(message),
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                    ));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    print(e);
                                  }
                                },
                                child: _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : Center(
                                        child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ))),
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  socialLinks('assets/google.png', 30),
                                  socialLinks('assets/apple.png', 20),
                                  socialLinks('assets/facebook.png', 20),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don’t have an account? ',
                                      style: TextStyle(
                                          wordSpacing: 3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final isValidForm =
                                            _formKey.currentState!.validate();
                                        if (isValidForm) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpScreen()),
                                                  (route) => false);
                                        }
                                      },
                                      child: Text(
                                        'Sign up ',
                                        style: TextStyle(
                                            color: Color(0xFF3D16D6),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    )
                                  ]),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}

Widget socialLinks(String imageUrl, double? imgHeight) {
  return Container(
    margin: EdgeInsets.only(right: 10.0),
    height: 50.0,
    width: 50.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle, color: Color(0xFF333333).withOpacity(0.08)),
    child: Image.asset(
      imageUrl,
      height: imgHeight ?? 10.0,
    ),
  );
}
// ||
// !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2-4}')
// .hasMatch(value!)
