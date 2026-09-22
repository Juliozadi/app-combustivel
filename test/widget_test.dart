import 'package:flutter_test/flutter_test.dart';

import 'package:app_combustivel/main.dart';

void main() {
  test('Álcool compensa', () {
    Combustivel combustivel = Combustivel(3.50, 5.50);
    expect(combustivel.calcular(), 'Abasteça com Álcool');
  });

  test('Gasolina compensa', () {
    Combustivel combustivel = Combustivel(4.50, 5.50);
    expect(combustivel.calcular(), 'Abasteça com Gasolina');
  });
}
