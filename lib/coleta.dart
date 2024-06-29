import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

const URL_PROFILE = 'http://localhost:8000/coleta/produtor/';

Future<dynamic> get(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final result = json.decode(response.body);
    if (result is List && result.length == 1) {
      return (result)[0];
    }
    return result;
  } else {
    throw Exception('Failed to load items from $url');
  }
}

Future<dynamic> post(String url, Map params) async {
  final response = await http.get(Uri.parse(url));
}


/// shortcuts
///

Future<dynamic> getProfile(int id) async {
  final result = await get("${URL_PROFILE}${id}");

  if (result is List && result.length == 1) {
    return (result)[0];
  }
  return result;
}


class Animal {

}

class Profile {
  final dynamic _data;

  Profile(this._data);

  int get id => _data['id'] as int;
  String get nome => "${_data['user']!['nome']}";
  String get email => "${_data['user']!['email']}";
  List get animais => _data['animais'] ?? [];
  List get produtos => _data['produtos'] ?? [];
  double get avaliacoes => 0;
  List get sitios => _data['sitios'] ?? [];

  void update(dynamic newValues) {
    (_data as Map).clear();
    (_data as Map).addAll(newValues);
  }
}

//// Path provider

final storage = RicoStorage();

class RicoStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/rico.json');
  }

  Future<dynamic> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      final jsonObj = json.decode(contents);

      return jsonObj;
    } catch (e) {
      return null;
    }
  }

  Future<File> saveData(dynamic data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(data));
  }
}
