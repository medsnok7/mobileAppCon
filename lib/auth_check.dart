import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileappconcorde/home/home_view.dart';
import 'package:mobileappconcorde/tools/tool_exports.dart';


class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const HomeView();
    } else {
      return const SignInView();
    }
  }
}
