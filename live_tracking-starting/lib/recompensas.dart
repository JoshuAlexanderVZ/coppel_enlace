import 'package:flutter/material.dart';

class RecompensasPage extends StatelessWidget {
  const RecompensasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón de regreso al menú
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const Center(
                child: Text(
                  'Recompensas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003DA5),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Sistema de puntos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF003DA5),
                ),
              ),
              const SizedBox(height: 8),
              const Text("Lecciones:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.star, size: 18, color: Colors.amber),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '1 punto por cada lección completada por un microempresario.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text('+10 puntos extra si completa 20 lecciones.'),
              const Text('+50 puntos extra si completa las 85 lecciones.'),
              const SizedBox(height: 8),
              const Text("Webinars:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text(
                  '+5 puntos extra por cada microempresario registrado que asista a un Webinar.'),
              const SizedBox(height: 20),

              const Text(
                'Premios',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF003DA5),
                ),
              ),
              const SizedBox(height: 10),

              // Premios
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _PremioCard(
                    puntos: 3000,
                    titulo: 'Días de vacaciones adicionales',
                    imagenPath: 'assets/premio1.png',
                  ),
                  _PremioCard(
                    puntos: 2000,
                    titulo: 'Incentivo en nómina',
                    imagenPath: 'assets/premio2.png',
                  ),
                  _PremioCard(
                    puntos: 1000,
                    titulo: '30% de descuento en tienda',
                    imagenPath: 'assets/premio3.png',
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total de puntos acumulados:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '3,500 puntos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003DA5),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AEEF),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Lógica para canjear premios
                  },
                  child: const Text(
                    'Canjear premios',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PremioCard extends StatelessWidget {
  final int puntos;
  final String titulo;
  final String imagenPath;

  const _PremioCard({
    required this.puntos,
    required this.titulo,
    required this.imagenPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagenPath,
                  width: 160,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                titulo,
                style: const TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
            ],
          ),
          Positioned(
            bottom: 22,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF003DA5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$puntos puntos',
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
