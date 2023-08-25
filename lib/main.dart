import 'package:mobileappconcorde/auth_check.dart';
import 'package:mobileappconcorde/home/profile/profile.dart';
import 'package:mobileappconcorde/tools/loading_page.dart';
import 'package:mobileappconcorde/tools/tool_exports.dart';
import 'db/provider/cart_provider.dart';
import 'home/cart/cart.dart';
import 'home/explore/explore.dart';
import 'home/home_view.dart';
import 'main_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const Directionality(
      textDirection:
          TextDirection.ltr, // Adjust this based on your app's language/locale
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBlocs(),
                ),
                BlocProvider(
                  create: (context) => SignUpBlocs(),
                ),
              ],
              child: ScreenUtilInit(
                builder: (BuildContext context, Widget? child) {
                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (_) => CartProvider(),
                      ),
                    ],
                    child: Builder(
                      builder: (context) {
                        return GetMaterialApp(
                          title: 'Flutter Demo',
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(
                            iconTheme: const IconThemeData(
                                color: AppColors.backgroundColor),
                            colorScheme: ColorScheme.fromSeed(
                                seedColor: AppColors.buttonColor),
                            useMaterial3: true,
                          ),
                          routes: {
                            '/': (context) => const SignInView(),
                            '/signup': (context) => const SignUpView(),
                            '/create': (context) => const CartView(),
                            '/home': (context) => const HomeView(),
                            '/profile': (context) => const ProfileView(),
                            '/explore': (context) => ExploreView(
                                  controller: ScrollController(),
                                ),
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}
