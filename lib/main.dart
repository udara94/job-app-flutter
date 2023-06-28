import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_app/models/navigation.dart';
import 'package:job_app/provider/navigation_provider.dart';
import 'package:job_app/provider/user.dart';
import 'package:job_app/resources/fonts.dart';
import 'package:job_app/screens/home.dart';
import 'package:job_app/screens/login.dart';
import 'package:job_app/screens/saved_jobs.dart';
import 'package:job_app/screens/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(create:(_)=> NavigationProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_)=> UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: Fonts.dmSans,
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => buildPages();

  Widget buildPages(){
    final provider = Provider.of<NavigationProvider>(context);
    final navigationItem = provider.navigationItem;

    switch(navigationItem){
      case NavigationItem.splash:
        return const SplashScreen();
      case NavigationItem.login:
        return const LoginScreen();
      case NavigationItem.home:
        return const HomeScreen();
      case NavigationItem.saveJobs:
        return const SavedJobsScreen();
    }
  }
}
