import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialpolice/custom_button.dart';
import 'package:socialpolice/dashboard.dart';
import 'package:socialpolice/sign_up_screen.dart';
import 'package:socialpolice/text_style.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
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
            top: 352,
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                    ],
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 420,
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
                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
                    ],
                    controller: _password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 506,
            left: 56,
            right: 56,
            child: Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: RaisedGradientButton(
                  child: Text(
                    'Login',
                    style: loginButtonstyle1,
                  ),
                  color: Color(0xff1877F2),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashBoard()),
                    );
                  }),
            ),
          ),
          Positioned(
            top: 639,
            left: 40,
            child: Container(
              width: 131,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                shape: BoxShape.rectangle,
                color: Color(0xffFFFFFF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/glogo.png",
                    width: 16,
                    height: 16,
                  ),
                  Text(
                    'Google',
                    style: logotextstyle,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 639,
            left: 183,
            right: 50,
            child: Container(
              width: 152,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                shape: BoxShape.rectangle,
                color: Color(0xff0A66C2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/flogo.png",
                    width: 16,
                    height: 16,
                  ),
                  Text(
                    'FaceBook',
                    style: logotextstyle2,
                  )
                ],
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
                    "Don't have an account?",
                    style: loginstyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
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
    );
  }
}
