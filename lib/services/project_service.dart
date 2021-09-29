import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:keluarga_bintoro/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectService {
 
  static Future<Projects> getProjectsData({String? role, int page = 1}) async {
    Future<Projects>? data;
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = "${role!}/select_schedule?page=$page";
    var client = http.Client();
    var response = await client.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return Projects.fromJosn(data);
    }
    return data!;
  }

  static Future<Projects> getProjectsDataByKeyword(
      {String? role, String? keyword}) async {
    Future<Projects>? data;
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = "${role!}/select_schedule?search=$keyword";
    var client = http.Client();
    var response = await client.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return Projects.fromJosn(data);
    }
    return data!;
  }

  static Future<Projects> searchData({String? role, String? text}) async {
    Future<Projects>? data;

    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = "${role!}/select_schedule?search=$text";
    var client = http.Client();
    var response = await client.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return Projects.fromJosn(data);
    }
    return data!;
  }

  static Future<Report> getListProject({String? role, int page = 1}) async {
    Future<Report>? data;

    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = "${role!}/report";
    var client = http.Client();
    var response = await client.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return Report.fromJson(data);
    }
    return data!;
  }

  static Future<List<Schedule>> getProjectsById(
      {String? role, String? id}) async {
    Future<List<Schedule>>? data;
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = role! + "/select_schedule/" + id!;
    var client = http.Client();
    var response = await client.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200) {
      return scheduleFromJson(response.body);
    }
    return data!;
  }

  static Future<bool> postReport({String? role, String? data}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = "${role!}/report";
    var client = http.Client();
    var response = await client.post(Uri.parse(url),
        body: data,
        encoding: utf8,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $value'
        });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
