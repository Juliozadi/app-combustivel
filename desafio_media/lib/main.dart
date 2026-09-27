import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: AppMedia()));
}

class AppMedia extends StatefulWidget {
  const AppMedia({super.key});

  @override
  State<AppMedia> createState() => _AppMediaState();
}

class _AppMediaState extends State<AppMedia> {
  TextEditingController valor1Controller = TextEditingController();
  TextEditingController valor2Controller = TextEditingController();
  TextEditingController valor3Controller = TextEditingController();
  String resultado = '';

  // Função que faz o cálculo da média
  void calcularMedia() {
    int valor1 = int.parse(valor1Controller.text);
    int valor2 = int.parse(valor2Controller.text);
    int valor3 = int.parse(valor3Controller.text);

    double media = (valor1 + valor2 + valor3) / 3;

    setState(() {
      resultado = 'A média é ${media.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Média')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: valor1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor 1'),
            ),
            TextField(
              controller: valor2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor 2'),
            ),
            TextField(
              controller: valor3Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor 3'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularMedia,
              child: const Text('Calcule a Média'),
            ),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
