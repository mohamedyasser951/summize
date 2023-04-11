// ignore_for_file: depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  static Future<String> getSummarize({required String text}) async {
    String mainUrl =
        "http://192.168.1.3:5000/example_endpoint?parameter_name=$text";
    var response = await http.get(Uri.parse(mainUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      throw Exception(response.statusCode);
    }
  }
}
