import 'package:flutter/material.dart';

void main() {
  runApp(const AppCombustivel());
}

/// Classe responsável pela regra de negócio: decidir qual combustível
/// compensa mais usando a Regra dos 70%.
///
/// Divide-se o preço do álcool pelo preço da gasolina:
/// - resultado menor que 0,70 -> o álcool (etanol) compensa;
/// - resultado igual ou maior que 0,70 -> a gasolina compensa.
class CalculadoraCombustivel {
  static const double limite = 0.70;

  final double precoAlcool;
  final double precoGasolina;

  CalculadoraCombustivel({
    required this.precoAlcool,
    required this.precoGasolina,
  });

  /// Retorna a razão entre o preço do álcool e o da gasolina.
  double calcularRazao() {
    return precoAlcool / precoGasolina;
  }

  /// Retorna `true` quando o álcool é a opção mais vantajosa.
  bool alcoolCompensa() {
    return calcularRazao() < limite;
  }

  /// Retorna o nome do combustível que compensa mais.
  String calcular() {
    return alcoolCompensa() ? 'Álcool' : 'Gasolina';
  }
}

class AppCombustivel extends StatelessWidget {
  const AppCombustivel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Combustível',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const TelaCombustivel(),
    );
  }
}

class TelaCombustivel extends StatefulWidget {
  const TelaCombustivel({super.key});

  @override
  State<TelaCombustivel> createState() => _TelaCombustivelState();
}

class _TelaCombustivelState extends State<TelaCombustivel> {
  // Controladores que guardam o texto digitado nos campos de entrada.
  final TextEditingController _alcoolController = TextEditingController();
  final TextEditingController _gasolinaController = TextEditingController();

  String _resultado = '';
  String _detalhe = '';
  Color _corResultado = Colors.black;

  @override
  void dispose() {
    _alcoolController.dispose();
    _gasolinaController.dispose();
    super.dispose();
  }

  /// Converte o texto digitado em número, aceitando vírgula ou ponto
  /// como separador decimal (ex.: "5,49" ou "5.49").
  double? _converterPreco(String texto) {
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  void _calcular() {
    final double? precoAlcool = _converterPreco(_alcoolController.text);
    final double? precoGasolina = _converterPreco(_gasolinaController.text);

    if (precoAlcool == null ||
        precoGasolina == null ||
        precoAlcool <= 0 ||
        precoGasolina <= 0) {
      setState(() {
        _resultado = 'Valores inválidos';
        _detalhe = 'Informe preços maiores que zero. Ex.: 3,89';
        _corResultado = Colors.red;
      });
      return;
    }

    final calculadora = CalculadoraCombustivel(
      precoAlcool: precoAlcool,
      precoGasolina: precoGasolina,
    );

    final double razao = calculadora.calcularRazao();
    final String percentual =
        (razao * 100).toStringAsFixed(1).replaceAll('.', ',');

    setState(() {
      _resultado = 'Abasteça com ${calculadora.calcular()}';
      _detalhe = 'O álcool custa $percentual% do preço da gasolina.';
      _corResultado =
          calculadora.alcoolCompensa() ? Colors.green : Colors.orange;
    });
  }

  void _limpar() {
    setState(() {
      _alcoolController.clear();
      _gasolinaController.clear();
      _resultado = '';
      _detalhe = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Álcool ou Gasolina'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.local_gas_station,
              size: 96,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            const Text(
              'Saiba qual combustível compensa mais para abastecer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Entrada de valores
            TextField(
              controller: _alcoolController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Preço do Álcool',
                hintText: 'Ex.: 3,89',
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _gasolinaController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Preço da Gasolina',
                hintText: 'Ex.: 5,89',
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _calcular(),
            ),
            const SizedBox(height: 24),

            // Ações
            ElevatedButton(
              onPressed: _calcular,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Calcular', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _limpar,
              child: const Text('Limpar'),
            ),
            const SizedBox(height: 24),

            // Resultado
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _corResultado,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _detalhe,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
