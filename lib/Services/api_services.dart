import 'dart:convert';

import 'package:coruscate_app_task/Model/data.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Data>> getData(String url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List body = jsonDecode(response.body);
        List<Data> data = body.map((e) => Data.fromJson(e)).toList();
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
