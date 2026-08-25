import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sorelia/data/local/app_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Crée un dossier temporaire pour la base de données durant le test
    final tempDir = await Directory.systemTemp.createTemp('sorelia_test');

    // Mocks du plugin path_provider pour intercepter l'appel natif
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return tempDir.path;
        }
        return null;
      },
    );
  });

  test('Vérification de la base de données et des coefficients', () async {
    final helper = DatabaseHelper.instance;

    final coefs = await helper.getCoefficientsRef(
      niveau: '3e',
      serie: 'TRONC_COMMUN',
    );

    expect(coefs, isNotEmpty);
  });
}