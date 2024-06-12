import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

String _baseUrl = "https://www.nipstudio.id/nitip/prsns/";

class ApiPrsns {
  final _storage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future login(String noKtp, String password) async {
    try {
      var request = Request('GET', Uri.parse('${_baseUrl}login.php'));
      request.body = jsonEncode({"no_ktp": noKtp, "password": password});

      StreamedResponse streamedResponse = await request.send();
      var response = await Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future logout() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      return e.toString();
    }
  }
}
