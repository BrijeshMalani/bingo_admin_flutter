import 'dart:convert';
import 'package:bingoadmin/utils/common.dart';
import 'package:http/http.dart' as http;

class PostService {
  static Future<dynamic> playerDataFetch({
    Map<String, dynamic>? reqBody,
    String? baseUrl,
  }) async {
    String url = "admin-app/apis/fetchPlayerInfo";
    String fullUrl = (baseUrl ?? Common.BASE_URL) + url;
    http.Response response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> updatePlayerInformation({
    Map<String, dynamic>? reqBody,
    String? baseUrl,
  }) async {
    String url = "admin-app/apis/updatePlayerInfo";
    String fullUrl = (baseUrl ?? Common.BASE_URL) + url;
    http.Response response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> updatePlayerProgress({
    Map<String, dynamic>? reqBody,
    String? baseUrl,
  }) async {
    String url = "admin-app/apis/updatePlayerProgress";
    String fullUrl = (baseUrl ?? Common.BASE_URL) + url;
    http.Response response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> deletePlayer({
    Map<String, dynamic>? reqBody,
    String? baseUrl,
  }) async {
    String url = "admin-app/apis/deletePlayer";
    String fullUrl = (baseUrl ?? Common.BASE_URL) + url;
    http.Response response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }
}