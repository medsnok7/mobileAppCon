import 'tool_exports.dart';

AppBar appBarWidget(String text, double size, Color color) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    titleSpacing: 2,
    title: Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    ),
  );
}

Widget appText(String text, Color color, FontWeight fontWeight, double size,
    textDecoration) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decorationColor: AppColors.textButtonColor,
        decoration: textDecoration),
  );
}

Widget appTextButton(String text, Color color, FontWeight fontWeight,
    double size, TextDecoration textDecoration) {
  return GestureDetector(
    child: appText(text, color, fontWeight, size, textDecoration),
  );
}

Widget appTextArea(
  // String text,
  TextEditingController? controller,
  double textSize,
  String hintText,
  bool obscureText,
  TextInputType keyboardType,
  Color color,
  double size,
  IconData icon,
  void Function(String value)? func,
  String? Function(String? value)? func1,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Container(
      //   height: textHeight,
      //     child: appText(
      //         text, color, FontWeight.bold, textSize, TextDecoration.none)),
      // SizedBox(height: 2.h),
      SizedBox(
        width: 320.w,
        height: 80.h,
        child: TextFormField(
          onChanged: (value) {
            return func!(value);
          },
          validator: func1,
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15.w),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15.w),
            ),
            prefixIcon: Icon(icon),
            prefixIconColor: Colors.black,
            hintText: hintText,
          ),
        ),
      ),
    ],
  );
}

Widget appRichText(
    BuildContext context,
    String text,
    String textButton,
    Color color1,
    Color color2,
    FontWeight fontWeight,
    double size,
    textDecoration) {
  return RichText(
    text: TextSpan(
      text: text,
      style: TextStyle(
          color: color1,
          fontSize: size,
          fontWeight: fontWeight,
          decorationColor: AppColors.textButtonColor,
          decoration: textDecoration),
      children: <TextSpan>[
        TextSpan(
          text: textButton,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (textButton == "Register now") {
                Get.to(() => const SignUpView(),
                    transition: Transition.leftToRight,
                    duration: const Duration(milliseconds: 500));
              } else {
                Get.to(() => const SignInView(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500));
              }
            },
          style: TextStyle(
              color: color2,
              fontSize: size,
              fontWeight: fontWeight,
              decorationColor: AppColors.textButtonColor,
              decoration: textDecoration),
        ),
      ],
    ),
  );
}

Widget appButton(
  String textButton,
  Color color,
  Color textColor,
  Color borderColor,
  double width,
  double height,
  double borderRadius,
  void Function()? func,
) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: borderColor,
            offset: const Offset(0, 0),
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        textButton,
        style: TextStyle(
            color: textColor,
            fontWeight: AppFontWeights.buttonTextFW,
            fontSize: AppSizes.buttonTextSize),
      ),
    ),
  );
}

Widget appButtonPrf(
  String textButton,
  Color color,
  Color textColor,
  Color borderColor,
  double width,
  double height,
  double borderRadius,
) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: borderColor,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          blurRadius: 1,
        )
      ],
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Center(
      child: Text(
        textButton,
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 16.sp),
      ),
    ),
  );
}

Widget appIcon(String imagePath) {
  return Container(
    width: 40.w,
    height: 40.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      color: Colors.purple,
    ),
  );
}

Widget thirdPartyWidget(BuildContext context) {
  return Container(
      width: 375.w,
      margin: EdgeInsets.only(top: 10.w, bottom: 10.w, left: 10.w, right: 10.w),
      child: Row(
        children: [
          Expanded(child: Container()),
          SizedBox(
            width: 150.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appIcon(""),
                appIcon(""),
                appIcon(""),
              ],
            ),
          ),
          Expanded(child: Container())
        ],
      ));
}

Widget appLine() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 1.h,
      width: 320.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(0.5)),
        color: Colors.black.withOpacity(0.15),
      ),
    ),
  );
}

Widget privacyPolicyLinkAndTermsOfService() {
  return Container(
    alignment: Alignment.center,
    width: 270.w,
    height: 65.h,
    padding: const EdgeInsets.all(10),
    child: Center(
        child: Text.rich(TextSpan(
            text: 'By continuing, you agree to our ',
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: <TextSpan>[
          TextSpan(
              text: 'Terms of Service',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // code to open / launch terms of service link here
                }),
          TextSpan(
              text: ' and the ',
              style: const TextStyle(fontSize: 18, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // code to open / launch privacy policy link here
                      })
              ])
        ]))),
  );
}
