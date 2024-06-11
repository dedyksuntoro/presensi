import 'dart:convert';

import 'package:http/http.dart';

String _baseUrl = "https://www.nipstudio.id/nitip/prsns/";

class ApiPrsns {
  Future login(String username, String password) async {
    try {
      Response response = await post(Uri.parse('${_baseUrl}login.php'),
          body: {'username': username, 'password': password});
      return jsonDecode(response.body.toString());
    } catch (e) {
      return e.toString();
    }
  }
}
