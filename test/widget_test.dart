import 'package:flutter_test/flutter_test.dart';
import 'package:sorelia/main.dart'; // Ajuste l'import si nécessaire

void main() {
  testWidgets('Onboarding page smoke test', (WidgetTester tester) async {
    // Charge l'application
    await tester.pumpWidget(const SoreliaApp());

    // Vérifie que le titre de bienvenue s'affiche correctement
    expect(find.text('Bienvenue sur Sorélia'), findsOneWidget);
  });
}