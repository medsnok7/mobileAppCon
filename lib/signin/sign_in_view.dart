// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileappconcorde/db/packages/cart_exports.dart';
import 'package:mobileappconcorde/home/home_view.dart';

import '../style/colors.dart';
import '../tools/widgets.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180.w,
                  width: 375.w,
                  decoration: const BoxDecoration(
                    color: AppColors.buttonColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: appText("Welcome!", AppColors.titleColor,
                      FontWeight.bold, 20.sp, TextDecoration.none),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      appTextArea(
                        email,
                        12.sp,
                        "enter your email address",
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
                      SizedBox(height: 5.h),
                      appTextArea(
                        password,
                        12.sp,
                        "enter your password",
                        true,
                        TextInputType.text,
                        AppColors.textColor,
                        12.sp,
                        Icons.lock,
                        (value) {},
                        (value) {
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 230.0),
                        child: appTextButton(
                            "Forgot password?",
                            AppColors.textButtonColor,
                            FontWeight.bold,
                            12.sp,
                            TextDecoration.none),
                      ),
                      SizedBox(height: 15.sp),
                      appButton(
                        "Login",
                        AppColors.buttonColor,
                        AppColors.buttonTextColor,
                        Colors.transparent,
                        320.w,
                        50.h,
                        15,
                        () async {
                          String email1 = email.text;
                          String password1 = password.text;
                          String error;
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email1, password: password1);
                            Get.to(() => const HomeView(),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 250));

                            print(userCredential);
                          } on FirebaseAuthException catch (e) {
                            switch (e.code) {
                              case "invalid-email":
                                error = "email is invalid";
                                break;
                              case "wrong-password":
                                error = "Wrong password";
                                break;
                              case "user-not-found":
                                error = "User is not found";
                                break;
                              default:
                                error = "something wrong happened";
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error)));
                          }
                        },
                      ),
                      SizedBox(height: 10.h),
                      appRichText(
                          context,
                          "Not a member? ",
                          "Register now",
                          AppColors.textColor.withOpacity(0.3),
                          AppColors.textButtonColor,
                          FontWeight.bold,
                          12.sp,
                          TextDecoration.none),
                      SizedBox(height: 10.h),
                    ],
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
