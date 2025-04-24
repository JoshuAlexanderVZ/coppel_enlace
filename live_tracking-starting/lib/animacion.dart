import 'package:flutter/material.dart';


import 'package:live_tracking/menu.dart';


class Animacion extends StatelessWidget {
  const Animacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RegistroExitoso(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistroExitoso extends StatefulWidget {
  const RegistroExitoso({super.key});

  @override
  State<RegistroExitoso> createState() => _RegistroExitosoState();
}

class _RegistroExitosoState extends State<RegistroExitoso>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                painter: CheckPainter(animation: _animation),
                size: const Size(100, 100),
              ),
              const SizedBox(height: 32),
              const Text(
                'Perfil actualizado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '!Listo¡ Tu perfil ha sido actualizado de\nmanera correcta.\n',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuScreen()),
                    );},
                child: const Text(
                  'Ir al Inicio',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckPainter extends CustomPainter {
  final Animation<double> animation;

  CheckPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paintCircle = Paint()
      ..color = Colors.transparent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final paintBorder = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final paintCheck = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw yellow circle
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paintBorder);

    // Draw animated check
    final path = Path();
    final double progress = animation.value;

    final start = Offset(size.width * 0.3, size.height * 0.55);
    final mid = Offset(size.width * 0.45, size.height * 0.7);
    final end = Offset(size.width * 0.75, size.height * 0.35);

    if (progress < 0.5) {
      final t = progress / 0.5;
      final current = Offset.lerp(start, mid, t)!;
      path.moveTo(start.dx, start.dy);
      path.lineTo(current.dx, current.dy);
    } else {
      path.moveTo(start.dx, start.dy);
      path.lineTo(mid.dx, mid.dy);
      final t = (progress - 0.5) / 0.5;
      final current = Offset.lerp(mid, end, t)!;
      path.lineTo(current.dx, current.dy);
    }

    canvas.drawPath(path, paintCheck);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}