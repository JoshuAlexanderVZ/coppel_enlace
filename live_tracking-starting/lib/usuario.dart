import 'package:flutter/material.dart';

class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String ciudad;
  final int edad;
  final String telefono;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.ciudad,
    required this.edad,
    required this.telefono,
  });
}

Future<Usuario> obtenerUsuarioPorId(String id) async {
  await Future.delayed(Duration(seconds: 1));

  return Usuario(
    id: id,
    nombre: 'Juan Perez',
    correo: 'Juan.Perez@example.com',
    ciudad: 'México',
    edad: 31,
    telefono: '+52 922 162 8843',
  );
}

class UserProfileCard extends StatelessWidget {
  final Usuario usuario;
  final String imageUrl;

  const UserProfileCard({
    super.key,
    required this.usuario,
    this.imageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(radius: 45, backgroundImage: NetworkImage(imageUrl)),
            SizedBox(height: 16),
            Text(
              usuario.nombre,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              usuario.correo,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            Divider(height: 30, thickness: 1.2),
            _buildInfoRow(Icons.location_city, 'Ciudad', usuario.ciudad),
            _buildInfoRow(Icons.cake, 'Edad', '${usuario.edad} años'),
            _buildInfoRow(Icons.phone, 'Teléfono', usuario.telefono),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 12),
          Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Usuario>(
        future: obtenerUsuarioPorId('1'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el usuario'));
          } else if (snapshot.hasData) {
            return UserProfileCard(usuario: snapshot.data!);
          } else {
            return Center(child: Text('No se encontró el usuario'));
          }
        },
      ),
    );
  }
}
