# App Combustível ⛽

App em Flutter que calcula de forma prática qual combustível compensa mais:
**Álcool x Gasolina**.

## Regra dos 70%

Divide-se o preço do álcool pelo preço da gasolina:

- resultado **menor que 0,70** → o **álcool (etanol)** vale a pena;
- resultado **igual ou maior que 0,70** → a **gasolina** é mais vantajosa.

## Como funciona o código (`lib/main.dart`)

- **`CalculadoraCombustivel`**: classe com os atributos `precoAlcool` e
  `precoGasolina` e os métodos do cálculo:
  - `calcularRazao()` → retorna `precoAlcool / precoGasolina`;
  - `alcoolCompensa()` → retorna `true` se a razão for menor que 0,70;
  - `calcular()` → retorna `'Álcool'` ou `'Gasolina'`.
- **Widgets de entrada**: dois `TextField` (preço do álcool e da gasolina),
  com teclado numérico e aceitando vírgula ou ponto como separador decimal.
- **Widgets de ação**: `ElevatedButton` **Calcular** (executa o cálculo) e
  `TextButton` **Limpar** (apaga os campos e o resultado).
- O resultado é exibido em um `Text` atualizado com `setState`.

## Como executar

```bash
flutter create .   # gera as pastas das plataformas (android, ios, web...)
flutter pub get
flutter run
```

## Testes

```bash
flutter test
```
