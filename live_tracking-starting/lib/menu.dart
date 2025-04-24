import 'package:flutter/material.dart';
import 'package:live_tracking/recompensas.dart';
import 'package:live_tracking/registroEmpresario.dart';
import 'package:live_tracking/agente.dart';
import 'package:live_tracking/logging.dart';
import 'package:live_tracking/buscador.dart';
import 'package:live_tracking/usuario.dart';
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menú', style: TextStyle(fontFamily: "CircularStd", color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              },
            ),
             ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('Registro de empresario'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistroScreen()),
                );
              },
            ), ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Busqueda de empresario'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MicroempresariosScreen()),
                );
              },
            ),  ListTile(
              leading: const Icon(Icons.adb_sharp),
              title: const Text('Agente de ayuda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BotWebPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard_rounded),
              title: const Text('Mis recompensas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecompensasPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserScreen()),
                );
              },
            ),
             ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Logging()),
                );
              },
            ),
            
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text('Menú', style: TextStyle(fontFamily: "CircularStd",color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 

    
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hola',
              style: TextStyle(fontFamily: "CircularStd",fontSize: 18, color: Colors.white),
            ),
            const Text(
              'Juan Pérez',
              style: TextStyle(fontFamily: "CircularStd",fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard('100', 'Microempresarios registrados', Colors.blue[800]!),
                const SizedBox(width: 20),
                _buildStatCard('100', 'Puntos acumulados', Colors.blue[800]!),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard('100', 'Lecciones', Colors.orange),
                const SizedBox(width: 10),
                _buildStatCard('5', 'Webinars', Colors.purple),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Aprendizaje en marcha',
              style: TextStyle(fontFamily: "CircularStd",fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Abril - Semana 1',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 15),
            _buildCustomChart(),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {},
                child: const Text(
                  '¿Necesitas ayuda con tus microempresarios?',
                  style: TextStyle(fontFamily: "CircularStd",color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color.fromRGBO(0, 169, 224, 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "CircularStd",
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 111, 183, 1),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: "CircularStd",fontSize: 14, color: Color.fromRGBO(0, 111, 183, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChart() {
    final days = ['D', 'L', 'Ma', 'Mi', 'J', 'V', 'S'];
    final values = [5, 10, 15, 20, 35, 30, 25];

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(days.length, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 35,
                      height: values[index] * 5.0,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 230, 0),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      days[index],
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}