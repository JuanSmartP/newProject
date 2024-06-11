// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infancia/ui/screens/registro/registro_screen.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void _starBackgroundService () async {
  //   await FlutterBackgroundService
  // }

  Future getPermission() async {
    LocationPermission permission;

    permission = await Geolocator.requestPermission();
  }

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  int indexCurrent = 0;
  List<Widget> screens = [
    const HomeBody(),
    const CasosScreen(),
    const SolicitudesScreen(),
    const RedesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color(0xFF6599fe),
        toolbarHeight: 100,
        leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset('assets/imgs/logo_home.svg')),
        title: const Text(
          'Infancia y Adolescencia',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'poppins',
              color: Colors.white),
        ),
        actions: const [CustomPopUp()],
      ),
      body: screens[indexCurrent],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, 'dashboard');
        },
        child:
            const Icon(color: Colors.white, Icons.dashboard_customize_outlined),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          currentIndex: indexCurrent,
          onTap: (value) {
            setState(() {
              indexCurrent = value;
            });
          },
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFF004897),
          unselectedItemColor: const Color(0xFF6599fe),
          items: [
            BottomNavigationBarItem(
                icon: indexCurrent == 0
                    ? const Image(
                        width: 20,
                        height: 20,
                        image:
                            AssetImage('assets/imgs/folder-open-02_active.png'))
                    : const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage(
                            'assets/imgs/folder-open-02_default.png')),
                label: 'Registros'),
            BottomNavigationBarItem(
                icon: indexCurrent == 1
                    ? const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage('assets/imgs/file-05_active.png'))
                    : const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage('assets/imgs/file-05_default.png')),
                label: 'Casos'),
            BottomNavigationBarItem(
                icon: indexCurrent == 2
                    ? const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage(
                            'assets/imgs/message-text-02_active.png'))
                    : const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage(
                            'assets/imgs/message-text-02_1_default.png')),
                label: 'Solicitudes'),

            BottomNavigationBarItem(
                icon: indexCurrent == 3
                    ? const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage('assets/imgs/phone_active.png'))
                    : const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage('assets/imgs/phone_2_default.png')),
                label: 'Redes'),
            // BottomNavigationBarItem(
            //     icon: indexCurrent == 3
            //         ? const Image(
            //             width: 20,
            //             height: 20,
            //             image: AssetImage('assets/imgs/phone_active.png'))
            //         : const Image(
            //             width: 20,
            //             height: 20,
            //             image: AssetImage('assets/imgs/phone.png')),
            //     label: 'Redes'),
          ],
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const RegistroFuncionarioScreen();
  }
}

// class CustomBody extends StatelessWidget {
//   const CustomBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [CustomCard(), CustomList()],
//     );
//   }
// }

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Card(
        color: const Color(0xFFffffff),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Buscar por identificacion',
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(50, 50),
                  backgroundColor: const Color(0xFF004897),
                ),
                onPressed: () {},
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
