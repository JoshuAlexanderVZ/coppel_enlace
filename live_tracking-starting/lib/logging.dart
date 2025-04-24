import 'package:flutter/material.dart';
import 'package:live_tracking/admin.dart';
import 'package:live_tracking/verificacion.dart';

// ✅ Asegúrate de definir esta pantalla (o cambia el nombre abajo donde indica)
class OtraPantalla extends StatelessWidget {
  const OtraPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Otra Pantalla')),
      body: Center(child: Text('Has ingresado el código 2423')),
    );
  }
}

class Logging extends StatelessWidget {
  const Logging({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController codigoController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/logo_fundacion.png',
                      height: 90,
                    ),
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/logo_coppel_emprende.png',
                      height: 40,
                    ),
                  ],
                ),
                const SizedBox(height: 90),

                const Text(
                  'Inicio de sesión',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF006FBA),
                  ),
                ),
                const SizedBox(height: 24),

                TextField(
                  cursorColor: Color(0xFF006FBA),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: Color.fromRGBO(0, 169, 224, 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF006FBA), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF006FBA), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: codigoController, // 👈 Controlador para leer el texto
                  obscureText: true,
                  cursorColor: Color(0xFF006FBA),
                  decoration: InputDecoration(
                    labelText: 'Código personal',
                    labelStyle: TextStyle(color: Color.fromRGBO(0, 169, 224, 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF006FBA), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF006FBA), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: () {
                    // 👇 Aquí decides la navegación según el código
                    if (codigoController.text == '2423') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ColaboradoresPage()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Verificacion()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A9E0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontFamily: "CircularStd",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    // Aquí puedes manejar el olvido del código si lo deseas
                  },
                  child: const Text(
                    '¿Olvidaste tu código personal?',
                    style: TextStyle(color: Color(0xFF006FBA)),
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
