import 'dart:convert';

import 'package:coruscate_app_task/Model/data.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Data>> getData(String url) async {
    try {
      http.Response response =
          await http.get(url); //using http package for getting url
      if (response.statusCode == 200) {
        List body = jsonDecode(response.body);
        List<Data> data = body
            .map((e) => Data.fromJson(e))
            .toList(); // Type casting the jason data into list
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
