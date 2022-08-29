import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../widgets/my_button.dart';
import '../../../widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  // TextEditingvalidateEmail(value) {
  //   if (value.isEmpty ||
  //       !value.contains('@') ||
  //       !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2-4}').hasMatch(value)) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }
  //
  // validateUserName(value) {
  //   if (value.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }
  //
  // validatePhoneNumber(value) {
  //   if (value.isEmpty ||
  //       !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$ ')
  //           .hasMatch(value)) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }
  //
  // validatePassword(value) {
  //   if (value.isEmpty || value.length < 7) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }Controller lastNameController = TextEditingController();

  //

  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  String _userFirstName = '';
  String _userLastName = '';
  String _userEmail = '';
  String _userPassword = '';
  String _userPhoneNumber = '';
  String _userAge = '';

  void _trySumbit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      _submitAuthForm(
          _userFirstName.trim(),
          _userLastName.trim(),
          _userEmail.trim(),
          _userPassword.trim(),
          _userPhoneNumber.trim(),
          _userAge.trim(),
          context);
    }
  }

  void _submitAuthForm(String firstName, String lastName, String email,
      String password, String phoneNumber, String age, BuildContext ctx) async {
    UserCredential authResult;
    try {
      //Login
      // authResult = await _auth.signInWithEmailAndPassword(
      //     email: email, password: password);
      // SignUp
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user?.uid)
          .set({
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "age": age
      });
      setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFAFAFA),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 18,
                ),
                Center(
                  child: Text(
                    'Create a new account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    'Fill all forms to continue',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        InputField(
                          validator: (value) {},
                          inputController: firstNameController,
                          isPassword: false,
                          hasSuffixIcon: false,
                          hintText: 'First Name',
                          prefixIcon: Image.asset(
                            'assets/person_icon.png',
                            color: Color(0xFF333333).withOpacity(0.8),
                          ),
                          onSaved: (value) {
                            _userFirstName = value;
                          },
                          keyBoardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          validator: (value) {},
                          inputController: lastNameController,
                          isPassword: false,
                          hasSuffixIcon: false,
                          hintText: 'Last Name',
                          prefixIcon: Image.asset(
                            'assets/person_icon.png',
                            color: Color(0xFF333333).withOpacity(0.8),
                          ),
                          onSaved: (value) {
                            _userLastName = value;
                          },
                          keyBoardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          validator: (value) {},
                          inputController: emailController,
                          isPassword: false,
                          keyBoardType: TextInputType.emailAddress,
                          hasSuffixIcon: false,
                          hintText: 'Email Address',
                          prefixIcon: Image.asset(
                            'assets/Icon_email.png',
                            color: Color(0xFF333333).withOpacity(0.8),
                          ),
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          validator: (value) {},
                          inputController: passwordController,
                          keyBoardType: TextInputType.visiblePassword,
                          isPassword: true,
                          hasSuffixIcon: true,
                          hintText: 'Password',
                          prefixIcon: Image.asset('assets/Icon_password.png'),
                          onSaved: (value) {
                            _userPassword = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          validator: (value) {},
                          inputController: ageController,
                          keyBoardType: TextInputType.number,
                          isPassword: false,
                          hasSuffixIcon: false,
                          hintText: 'Input Age',
                          prefixIcon: SizedBox.shrink(),
                          onSaved: (value) {
                            _userAge = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InputField(
                          validator: (value) {},
                          inputController: phoneNumberController,
                          isPassword: false,
                          keyBoardType: TextInputType.phone,
                          hasSuffixIcon: false,
                          hintText: 'Phone Number',
                          textInputAction: TextInputAction.done,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xFF333333).withOpacity(0.8),
                          ),
                          onSaved: (value) {
                            _userPhoneNumber = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        MyButton(
                            onPressed: _trySumbit,
                            child: _isLoading
                                ? Center(
                                    child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: CircularProgressIndicator(),
                                  ))
                                : Center(
                                    child: Text(
                                    'Sign Up',
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
                                  'Already have an account? ',
                                  style: TextStyle(
                                      wordSpacing: 3,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: _trySumbit,
                                  child: Text(
                                    'Sign in ',
                                    style: TextStyle(
                                        color: Color(0xFF3D16D6),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
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
      height: imgHeight ?? 20.0,
    ),
  );
}
