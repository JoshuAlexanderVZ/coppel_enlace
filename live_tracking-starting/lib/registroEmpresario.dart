import 'package:flutter/material.dart';
import "package:live_tracking/firebase.dart";

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _confirmarContrasenaController = TextEditingController();
  final _codigoPostalController = TextEditingController();
  final _telefonoController = TextEditingController();
  String? _tipoCliente;

  void _registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      final usuario = {
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'contrasena': _contrasenaController.text,
        'confirmar_contrasena': _confirmarContrasenaController.text,
        'codigo_postal': _codigoPostalController.text,
        'tipo_cliente': _tipoCliente,
        'telefono': _telefonoController.text,
      };

      final dbHelper = DatabaseHelper();
      await dbHelper.insertarUsuario(usuario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado exitosamente')),
      );

      _formKey.currentState!.reset();
      _nombreController.clear();
      _apellidoController.clear();
      _contrasenaController.clear();
      _confirmarContrasenaController.clear();
      _codigoPostalController.clear();
      _telefonoController.clear();
      setState(() {
        _tipoCliente = null;
      });
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Ingresa los datos', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Registrar\nmicroempresarios',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "CircularStd",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _nombreController,
                  decoration: _inputDecoration('Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _apellidoController,
                  decoration: _inputDecoration('Apellidos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu apellido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _contrasenaController,
                  decoration: _inputDecoration('Contraseña'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    if (value.length != 4 || !RegExp(r'^[0-9]{4}$').hasMatch(value)) {
                      return 'La contraseña debe ser un número de 4 dígitos';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _confirmarContrasenaController,
                  decoration: _inputDecoration('Confirmar contraseña'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor confirma tu contraseña';
                    }
                    if (value != _contrasenaController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _codigoPostalController,
                  decoration: _inputDecoration('Código postal'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu código postal';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('¿Qué tipo de cliente eres?'),
                  items: [
                    DropdownMenuItem(value: 'Cliente BanCoppel', child: Text('Cliente BanCoppel')),
                    DropdownMenuItem(value: 'Crédito Coppel', child: Text('Crédito Coppel')),
                    DropdownMenuItem(value: 'Afore Coppel', child: Text('Afore Coppel')),
                    DropdownMenuItem(value: 'No soy cliente', child: Text('No soy cliente')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _tipoCliente = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona una opción';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _telefonoController,
                  decoration: _inputDecoration('No. de teléfono').copyWith(
                    prefixText: '+52 ',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu número de teléfono';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (_) {}),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                          children: [
                            TextSpan(text: 'Acepto los '),
                            TextSpan(
                              text: 'términos y condiciones',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(text: ' y el '),
                            TextSpan(
                              text: 'aviso de privacidad',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Por seguridad enviaremos un mensaje a tu teléfono para validar tu información.',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _registrarUsuario,
                  child: Text(
                    'Registrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
