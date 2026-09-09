import 'package:flutter_test/flutter_test.dart';
import 'package:sorelia/main.dart';

void main() {
  testWidgets('Onboarding page smoke test', (WidgetTester tester) async {
    // Charge l'application avec le const requis
    await tester.pumpWidget(const SoreliaApp());

    // Attend la fin des animations et chargements initiaux
    await tester.pumpAndSettle();

    // Vérifie qu'au moins un widget est présent à l'écran
    expect(find.byType(SoreliaApp), findsOneWidget);
  });
}
