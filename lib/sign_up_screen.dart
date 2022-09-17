import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socialpolice/dashboard.dart';
import 'package:socialpolice/login_screen.dart';
import 'package:socialpolice/text_style.dart';

import 'custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background.png'),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff276EF1).withOpacity(0.9),
                    Color(0xffFFFFFF).withOpacity(0.2),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 95,
              left: 35,
              child: Text(
                'SLEECS',
                style: loginTextstyle,
              ),
            ),
            Positioned(
              top: 161,
              left: 35,
              child: SizedBox(
                height: 84,
                width: 310,
                child: RichText(
                  text: TextSpan(
                    style: loginTextstyle1,
                    children: <TextSpan>[
                      TextSpan(text: 'Keeping the \nstreets'),
                      TextSpan(
                          text: ' Safer',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 313,
              left: 40,
              child: Container(
                width: 295,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffFBEEFF),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffFBEEFF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: "Montserrat-Regular",
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                          hintText: 'First Name',
                          labelStyle: TextStyle(color: Color(0xffBEBDBD))),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                      // ],
                      controller: _firstname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter your Firstname';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 381,
              left: 40,
              child: Container(
                width: 295,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffFBEEFF),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffFBEEFF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: "Montserrat-Regular",
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                          hintText: 'Last Name',
                          labelStyle: TextStyle(color: Color(0xffBEBDBD))),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"))
                      ],
                      controller: _lastname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter your lastname';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 449,
              left: 40,
              child: Container(
                width: 295,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffFBEEFF),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffFBEEFF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: "Montserrat-Regular",
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                          hintText: 'Email',
                          labelStyle: TextStyle(color: Color(0xffBEBDBD))),
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                      // ],
                      controller: _email,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 517,
              left: 40,
              child: Container(
                width: 295,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffFBEEFF),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffFBEEFF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: "Montserrat-Regular",
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                          hintText: 'Password',
                          labelStyle: TextStyle(color: Color(0xffBEBDBD))),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"))
                      ],
                      controller: _password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 608,
              left: 56,
              right: 56,
              child: Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: RaisedGradientButton(
                  child: Text(
                    'Sign Up',
                    style: loginButtonstyle1,
                  ),
                  color: Color(0xff1877F2),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const DashBoard()),
                      // );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              top: 732,
              left: 105,
              right: 77,
              child: Container(
                height: 17,
                width: 207,
                child: Row(
                  children: [
                    Text(
                      "Have an account?",
                      style: loginstyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        " Log In",
                        style: reminderstyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 783,
              left: 33,
              right: 40,
              child: SizedBox(
                height: 14,
                width: 390,
                child: RichText(
                  text: TextSpan(
                    style: termscondiion,
                    children: <TextSpan>[
                      TextSpan(text: 'By signing up, you are agree with our'),
                      TextSpan(
                          text: 'Terms & Conditions',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1877F2))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
