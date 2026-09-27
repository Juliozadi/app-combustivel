import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: AppCombustivel()));
}

// Classe com o método que faz o cálculo (Regra dos 70%)
class Combustivel {
  double alcool;
  double gasolina;

  Combustivel(this.alcool, this.gasolina);

  String calcular() {
    double resultado = alcool / gasolina;

    if (resultado < 0.7) {
      return 'Abasteça com Álcool';
    } else {
      return 'Abasteça com Gasolina';
    }
  }

  // Método que faz o cálculo da média dos valores
  double calcularMedia() {
    return (alcool + gasolina) / 2;
  }
}

class AppCombustivel extends StatefulWidget {
  const AppCombustivel({super.key});

  @override
  State<AppCombustivel> createState() => _AppCombustivelState();
}

class _AppCombustivelState extends State<AppCombustivel> {
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String resultado = '';
  String media = '';

  void calcular() {
    double alcool = double.parse(alcoolController.text);
    double gasolina = double.parse(gasolinaController.text);

    Combustivel combustivel = Combustivel(alcool, gasolina);

    setState(() {
      resultado = combustivel.calcular();
    });
  }

  // Função chamada ao clicar em "Calcule a Média"
  void calcularMedia() {
    double alcool = double.parse(alcoolController.text);
    double gasolina = double.parse(gasolinaController.text);

    Combustivel combustivel = Combustivel(alcool, gasolina);

    setState(() {
      media = 'Média: R\$ ${combustivel.calcularMedia().toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Álcool ou Gasolina')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: alcoolController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Preço do Álcool'),
            ),
            TextField(
              controller: gasolinaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Preço da Gasolina'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcular,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularMedia,
              child: const Text('Calcule a Média'),
            ),
            const SizedBox(height: 20),
            Text(media, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
