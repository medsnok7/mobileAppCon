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
                appButton(
                    "Change Password",
                    AppColors.themeColor,
                    AppColors.titleColor,
                    Colors.transparent,
                    360.w,
                    50.h,
                    0,
                    () {}),
                SizedBox(height: 1.h),
                appButton("Log Out", AppColors.themeColor, AppColors.titleColor,
                    Colors.transparent, 360.w, 50.h, 0, () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Get.to(() => const SignInView(),
                        duration: const Duration(milliseconds: 250));
                  } catch (e) {
                    print(e);
                  }
                }),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ));
  }
}
