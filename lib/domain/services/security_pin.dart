import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinSecurity {
  static const _storage = FlutterSecureStorage();
  static const _sessionKey = 'sorelia_session_eleve_id';

  // Hache le PIN saisi par l'élève. Le résultat, jamais le PIN en clair,
  
  static String hashPin(String pin) {
    return sha256.convert(utf8.encode(pin)).toString();
  }

  static bool verifyPin(String pin, String hashedPin) {
    return hashPin(pin) == hashedPin;
  }

  
  static Future<void> saveSession(int eleveId) async {
    await _storage.write(key: _sessionKey, value: eleveId.toString());
  }

  static Future<int?> getSession() async {
    final value = await _storage.read(key: _sessionKey);
    return value == null ? null : int.tryParse(value);
  }

  static Future<void> clearSession() async {
    await _storage.delete(key: _sessionKey);
  }
}