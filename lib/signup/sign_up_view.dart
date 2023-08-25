// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/colors.dart';
import '../signin/sign_in_view.dart';
import '../tools/checkbox.dart';
import '../tools/widgets.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController userName;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController rePassword;

  @override
  void initState() {
    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    rePassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    password.dispose();
    rePassword.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  bool isSame = false;
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
        top: true,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: appBarWidget("Sign up", 16.sp, AppColors.titleColor),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 20.0, right: 20.0, bottom: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      appTextArea(
                        userName,
                        12.sp,
                        "john.doe",
                        false,
                        TextInputType.text,
                        AppColors.textColor,
                        12.sp,
                        Icons.home,
                        (value) {},
                        (value) {
                          return null;
                        },
                      ),
                      appTextArea(
                        email,
                        12.sp,
                        "john.doe@gmail.com",
                        false,
                        TextInputType.emailAddress,
                        AppColors.textColor,
                        12.sp,
                        Icons.person,
                        (value) {},
                        (value) {
                          return null;
                        },
                      ),
                      appTextArea(
                        password,
                        12.sp,
                        "Create a password",
                        true,
                        TextInputType.text,
                        AppColors.textColor,
                        12.sp,
                        Icons.lock,
                        (value) {},
                        (value) {
                          bool isUpperCase = false;
                          int j = 0;
                          for (var i = 0; i < value!.length; i++) {
                            if (value[i] == value[i].toUpperCase() &&
                                value[i].isAlphabetOnly) {
                              j += 1;
                            }
                          }
                          if (value.isEmpty) {
                            return 'Please enter a password.';
                          }
                          if (value.length < 8 || j < 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        '''Use a mix of uppercase and lowercase letters.\nMake it at least 8 characters long''')));
                            return 'Password is weak ';
                          }
                          return null;
                        },
                      ),
                      // FlutterPwValidator(
                      //   controller: password,
                      //   minLength: 8,
                      //   uppercaseCharCount: 1,
                      //   width: 300.w,
                      //   height: 60.h,
                      //   onSuccess: () {
                      //     setState(() {
                      //       isSuccess = true;
                      //     });
                      //   },
                      //   onFail: () {
                      //     setState(() {
                      //       isSuccess = false;
                      //     });
                      //   },
                      // ),
                      appTextArea(
                        rePassword,
                        12.sp,
                        "Confirm password",
                        true,
                        TextInputType.emailAddress,
                        AppColors.textColor,
                        12.sp,
                        Icons.lock,
                        (value) {},
                        (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm the password.';
                          }
                          if (value != password.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CheckBox(),
                          privacyPolicyLinkAndTermsOfService(),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      appButton(
                          "Signup",
                          AppColors.buttonColor,
                          AppColors.buttonTextColor,
                          Colors.transparent,
                          300.w,
                          50.h,
                          15, () async {
                        String error;
                        String email1 = email.text;
                        String password1 = password.text;
                        try {
                          if (_formKey.currentState!.validate() == false) {
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email1, password: password1);
                            User user = userCredential.user!;
                            await user.updateDisplayName(userName.text);
                            print(userCredential);
                            Get.to(() => const SignInView(),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500));
                            print(rePassword.text.length.toString());
                          }
                        } on FirebaseAuthException catch (e) {
                          switch (e.code) {
                            case "invalid-email":
                              error = "Email is invalid";
                              break;
                            case "weak-password":
                              error = "Password is weak";
                              break;
                            case "email-already-in-use":
                              error = "Email is already in use";
                              break;
                            default:
                              error = "Please enter your data";
                          }
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(error)));
                        }
                      }),
                      SizedBox(height: 5.h),
                      appRichText(
                          context,
                          "Have an account? ",
                          "Login",
                          AppColors.textColor.withOpacity(0.3),
                          AppColors.textButtonColor,
                          FontWeight.bold,
                          12.sp,
                          TextDecoration.none),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
