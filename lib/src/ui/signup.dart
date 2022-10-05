import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/dimens.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/ui/components/buttons.dart';
import 'package:socialpolice/src/ui/components/input_text.dart';
import 'package:socialpolice/src/utils/navigations.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController? usernameContrl, emailCtrlr, passCtrlr, fName, lName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameContrl = TextEditingController();
    emailCtrlr = TextEditingController();
    passCtrlr = TextEditingController();
    fName = TextEditingController();
    lName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: AppColors.gradientApp,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimens.screenHeight * 0.1), //10%
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'SLEECS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Keeping the',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'street',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        color: Colors.white,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' Safer',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimens.screenHeight * 0.05), //5%
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Dimens.screenHeight * 0.03,
                  ),
                  child: InputText(
                    placeholder: 'Username',
                    controller: usernameContrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Dimens.screenHeight * 0.03,
                  ),
                  child: InputText(
                    placeholder: 'First Name',
                    controller: fName,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Dimens.screenHeight * 0.03,
                  ),
                  child: InputText(
                    placeholder: 'Last Name',
                    controller: lName,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Dimens.screenHeight * 0.03,
                  ),
                  child: InputText(
                    placeholder: 'Email',
                    controller: emailCtrlr,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: Dimens.screenHeight * 0.03),
                  child: InputText(
                    placeholder: 'Password',
                    controller: passCtrlr,
                    secureTextEntry: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: AppButton(
                    onPressed: () {},
                    text: 'Sign Up',
                    size: ButtonSize.FULL,
                    primaryColor: AppColors.colorPrimary,
                    radius: 60,
                  ),
                ),
                SizedBox(height: Dimens.screenHeight * 0.03),
                Center(
                  child: InkWell(
                    onTap: () => AppRoute.pop(context),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' Login',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: AppColors.colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimens.screenHeight * 0.03),
                Center(
                  child: InkWell(
                    onTap: () => AppRoute.navigatePush(
                        context: context, page: const Signup()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: TextSpan(
                          text: 'By signing up, you are agree with our ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: ' Terms & Conditions',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: AppColors.colorlemonGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
