import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as Math;



int getUserID() {
  return 1;
}



http.Client _client = http.Client();

// const String BASE_URL = 'http://rico-cidts-39c8247ce62e.herokuapp.com';

const String BASE_URL = 'http://192.168.100.54:8000';


Future<dynamic> _fetch(http.Client cli, String url) async {
  return _client.get(Uri.parse(url)).then((resp) => json.decode(resp.body));
}

Future<dynamic> getAnimals() async {
  return _fetch(_client, '$BASE_URL/coleta/animais/');
}


Future<dynamic> getProdutor() async {
  return _fetch(_client, '$BASE_URL/coleta/produtor/');
}

class Animal {

  final Map<String, dynamic> _data;
  final Produtor produtor;

  Animal(this._data, this.produtor);

  DateTime? get nascimento => DateTime.tryParse(_data['nascimento'] as String);
  DateTime? get abatimento => DateTime.tryParse(_data['abatimento'] as String);
  String get sexo => _data['sexo'] as String;
  String get raca => _data['raca'] as String;
  int get id => _data['id'] as int;

  @override
  String toString() {
    try {
      int days = DateTime.now().difference(nascimento!).inDays;

      if(days <= 6 * 30) {
        return sexo == 'M' ? 'Cordeiro' : 'Cordeira';
      } else if(days <= 12 * 30) {
        return sexo == 'M' ? 'Borrego' : 'Borrega';
      } else {
        return sexo == 'M' ? 'Carneiro' : 'Carneira';
      }

    } catch (e) {
      return sexo == 'M' ? 'Carneiro' : 'Carneira';
    }

  }

}

class Produto {

  final Map<String, dynamic> _data;
  final Produtor produtor;

  Produto(this._data, this.produtor);

  String get informacoes => _data['informacoes'] as String;
  String get corte => _data['corte'] as String;
  List<dynamic> get avaliacoes => _data['avaliacoes'] as List<dynamic>;

  double get nota => (
      avaliacoes.map((a) => a['conceito'] as String).map(
      (conceito) => conceito.startsWith('S') ? 3 : conceito.startsWith('N') ? 2 : 1
  ).reduce((value, element) => value + element) / avaliacoes.length * .33);

  @override
  String toString() => '$corte ($avaliacoes)';

}


class Produtor {

  final Map<String, dynamic> _data;

  String get nome => user?['nome'] as String;
  String get email => user?['email'] as String;

  List<dynamic> get animais => (_data['animais'] as List<dynamic>).map((e) => Animal(e, this)).toList();
  List<dynamic> get produtos => (_data['produtos'] as List<dynamic>).map((e) => Produto(e, this)).toList();


  Map<String, dynamic>? get user => _data['user'] as Map<String, dynamic>;

  Produtor(this._data);

}