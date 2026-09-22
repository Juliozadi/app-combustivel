import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_combustivel/main.dart';

void main() {
  group('CalculadoraCombustivel', () {
    test('álcool compensa quando a razão é menor que 0,70', () {
      final calculadora =
          CalculadoraCombustivel(precoAlcool: 3.50, precoGasolina: 5.50);

      expect(calculadora.calcularRazao(), closeTo(0.636, 0.001));
      expect(calculadora.alcoolCompensa(), isTrue);
      expect(calculadora.calcular(), 'Álcool');
    });

    test('gasolina compensa quando a razão é maior que 0,70', () {
      final calculadora =
          CalculadoraCombustivel(precoAlcool: 4.50, precoGasolina: 5.50);

      expect(calculadora.alcoolCompensa(), isFalse);
      expect(calculadora.calcular(), 'Gasolina');
    });

    test('gasolina compensa quando a razão é exatamente 0,70', () {
      final calculadora =
          CalculadoraCombustivel(precoAlcool: 3.50, precoGasolina: 5.00);

      expect(calculadora.calcular(), 'Gasolina');
    });
  });

  testWidgets('calcula o combustível a partir dos valores digitados',
      (tester) async {
    await tester.pumpWidget(const AppCombustivel());

    await tester.enterText(find.byType(TextField).at(0), '3,50');
    await tester.enterText(find.byType(TextField).at(1), '5,50');
    await tester.tap(find.text('Calcular'));
    await tester.pump();

    expect(find.text('Abasteça com Álcool'), findsOneWidget);
    expect(find.text('O álcool custa 63,6% do preço da gasolina.'),
        findsOneWidget);
  });

  testWidgets('mostra erro quando os valores são inválidos', (tester) async {
    await tester.pumpWidget(const AppCombustivel());

    await tester.enterText(find.byType(TextField).at(0), 'abc');
    await tester.tap(find.text('Calcular'));
    await tester.pump();

    expect(find.text('Valores inválidos'), findsOneWidget);
  });
}
