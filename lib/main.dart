import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:infancia/domain/preferences/preferences.dart';
import 'package:infancia/ui/screens/dashboard/dashboard_main.dart';
import 'package:infancia/ui/screens/entrevista_view/entrevista_view.dart';
import 'package:infancia/ui/screens/pf_inside/pf_inside.dart';
import 'package:infancia/ui/screens/profile/profile_page.dart';
import 'package:infancia/ui/screens/victima/existe_victima.dart';
import 'ui/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  //Permisos de ubicacion
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        'login': (context) => const CustomLoginScreen(),
        'home': (context) => const HomeScreen(),
        'verificar': (context) => ExisteVictimaDenuncia(),
        'solicitudes': (context) => AddCanalMain(),
        'profile': (context) => const ProfilePage(),
        'change_password': (context) => const ChangePassword(),
        'about': (context) => const AboutPage(),
        'pf': (context) => PfPage(),
        'pf_inside': (context) => const PfInside(),
        'e_view': (context) => const EntrevistaView(),
        'dashboard': (context) => const DashBoardMain()
      },
    );
  }
}


//TODO:  PEDIR LA UBICACION AL INICIAR LA APLICACION 