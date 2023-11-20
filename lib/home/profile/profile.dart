// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

import 'package:mobileappconcorde/tools/tool_exports.dart';

import '../../tools/widgets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          children: [
            Expanded(child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Positioned(
                      child: Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.h),
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.h),
                            color: AppColors.backgroundColor,
                          ),
                          child: const Icon(
                            Icons.photo_camera,
                            color: AppColors.iconColor,
                          ),
                        ))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      appText(
                          FirebaseAuth.instance.currentUser!.displayName ??
                              "Unknown",
                          AppColors.titleColor,
                          FontWeight.bold,
                          18.sp,
                          TextDecoration.none),
                      appText(
                          FirebaseAuth.instance.currentUser!.email!,
                          AppColors.titleColor.withOpacity(0.5),
                          FontWeight.bold,
                          15.sp,
                          TextDecoration.none),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      appButton(
                          "Change Password",
                          AppColors.backgroundColor,
                          AppColors.titleColor,
                          Colors.transparent,
                          290.w,
                          45.h,
                          0,
                          () {}),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.h)),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 2.h,
                  width: 340.w,
                  color: AppColors.titleColor.withOpacity(0.1),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      appButton(
                        "Log Out",
                        AppColors.backgroundColor,
                        AppColors.titleColor,
                        Colors.transparent,
                        290.w,
                        45.h,
                        0,
                        () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            Get.to(() => const SignInView(),
                                duration: const Duration(milliseconds: 250));
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.h)),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 2.h,
                  width: 340.w,
                  color: AppColors.titleColor.withOpacity(0.1),
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ));
  }
}
