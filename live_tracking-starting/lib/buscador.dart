import 'package:flutter/material.dart';

class Buscador extends StatelessWidget {
  const Buscador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seguimiento de Microempresarios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00A9E0),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const MicroempresariosScreen(),
    );
  }
}

class MicroempresariosScreen extends StatefulWidget {
  const MicroempresariosScreen({super.key});

  @override
  State<MicroempresariosScreen> createState() => _MicroempresariosScreenState();
}

class _MicroempresariosScreenState extends State<MicroempresariosScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showResults = false;


  final List<Map<String, dynamic>> _microempresarios = [
    {
      'nombre': 'Luis Alfonso Lopez',
      'lecciones': {'completadas': 25, 'total': 85, 'puntos': 35},
      'webinars': {'completados': 1, 'total': 5, 'puntos': 5},
      'total_puntos': 40,
    },
    {
      'nombre': 'María Pérez',
      'lecciones': {'completadas': 50, 'total': 85, 'puntos': 50},
      'webinars': {'completados': 2, 'total': 5, 'puntos': 10},
      'total_puntos': 60,
    },
    {
      'nombre': 'Carlos Hernández',
      'lecciones': {'completadas': 10, 'total': 85, 'puntos': 10},
      'webinars': {'completados': 0, 'total': 5, 'puntos': 0},
      'total_puntos': 10,
    },
  ];

  List<Map<String, dynamic>> _filteredMicroempresarios = [];

  @override
  void initState() {
    super.initState();
    _filteredMicroempresarios = [];
    _searchController.addListener(_filterResults);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterResults() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _showResults = false;
        _filteredMicroempresarios = [];
      } else {
        _showResults = true;
        _filteredMicroempresarios = _microempresarios
            .where((microempresario) =>
                microempresario['nombre'].toLowerCase().contains(query))
            .toList();
      }
    });
  }


  Map<String, dynamic> _safeGet(
      Map<String, dynamic>? data, String key, Map<String, dynamic> defaults) {
    if (data == null || data[key] == null) {
      return defaults;
    }
    return data[key];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento de microempresarios'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de búsqueda
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar microempresario...',
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF00A9E0)),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF00A9E0)),
                    onPressed: () {
                      _searchController.clear();
                      _filterResults();
                    },
                  ),
                ),
                onSubmitted: (_) => _filterResults(),
              ),
            ),
            const SizedBox(height: 20),


            if (_showResults) ...[
              const Text(
                'Seguimiento de microempresarios',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),
              if (_filteredMicroempresarios.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'No se encontraron resultados',
                    style: TextStyle(fontSize: 16, color: Color(0xFF00A9E0)),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredMicroempresarios.length,
                    itemBuilder: (context, index) {
                      final microempresario = _filteredMicroempresarios[index];

       
                      final lecciones = _safeGet(microempresario, 'lecciones',
                          {'completadas': 0, 'total': 1, 'puntos': 0});
                      final webinars = _safeGet(microempresario, 'webinars',
                          {'completados': 0, 'total': 1, 'puntos': 0});
                      final totalPuntos = microempresario['total_puntos'] ?? 0;

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Color(0xFF00A9E0),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                microempresario['nombre'] ??
                                    'Nombre no disponible',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),

              
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F9FA),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
      
                                    _buildProgressBar(
                                      title: 'Lecciones',
                                      completed: lecciones['completadas'],
                                      total: lecciones['total'],
                                      points: lecciones['puntos'],
                                      color: const Color(0xFF00A9E0),
                                    ),
                                    const SizedBox(height: 20),

                                    _buildProgressBar(
                                      title: 'Webinars',
                                      completed: webinars['completados'],
                                      total: webinars['total'],
                                      points: webinars['puntos'],
                                      color: Color(0xFF00A9E0),
                                    ),
                                    const SizedBox(height: 20),

                                    Text(
                                      'Total de puntos: $totalPuntos',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF00A9E0),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ] else ...[
              const Expanded(
                child: Center(
                  child: Text(
                    'Ingrese un nombre para buscar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF00A9E0),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar({
    required String title,
    required int completed,
    required int total,
    required int points,
    required Color color,
  }) {
    final progress = total > 0 ? completed / total : 0.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor:Color(0xFF00A9E0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$completed/$total - Puntos: $points',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF00A9E0),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}