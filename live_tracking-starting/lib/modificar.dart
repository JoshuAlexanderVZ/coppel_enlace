import 'package:flutter/material.dart';

class Modificar extends StatefulWidget {
  const Modificar({super.key});

  @override
  State<Modificar> createState() => _MyAppState();
}

class _MyAppState extends State<Modificar> {
  bool _isEditing = false;
  final Map<String, String> _profileData = {
    'Nombre': 'Juan ',
    'Apellidos': 'Pérez Castillo',
    'Fecha de nacimiento': '24/12/1999',
    'Correo electrónico': 'juancolabcoppel@gmail.com',
    'Nivel educativo': 'Preparatoria',
    'Género': 'Masculino',
    'Código postal': '96714',
    'Estado': 'Veracruz',
  };

  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();

    for (var key in _profileData.keys) {
      _controllers[key] = TextEditingController(text: _profileData[key]);
    }
  }

  @override
  void dispose() {

    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('PERFIL DEL COLABORADOR'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                 
                  for (var key in _profileData.keys) {
                    _profileData[key] = _controllers[key]!.text;
                  }
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mi perfil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ..._buildProfileFields(),
              const SizedBox(height: 30),
              if (_isEditing)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                  
                        for (var key in _profileData.keys) {
                          _profileData[key] = _controllers[key]!.text;
                        }
                        _isEditing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Perfil actualizado correctamente')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Guardar cambios',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProfileFields() {
    return _profileData.keys.map((label) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              width: double.infinity,
              child: _isEditing
                  ? TextField(
                      controller: _controllers[label],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 16),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        _profileData[label]!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

