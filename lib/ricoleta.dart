import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';



int getUserID() {
  return 1;
}



http.Client _client = http.Client();
String? cookie;


// Função para criar o cabeçalho de autenticação básica
String basicAuth(String username, String password) {
  String credentials = '$username:$password';
  ByteData bytes = ByteData.view(Uint8List.fromList(credentials.codeUnits).buffer);
  String encoded = base64.encode(bytes.buffer.asUint8List());
  return 'Basic $encoded';
}
final client = http.Client();

Future<void> acessLogada() async {
  Uri url = Uri.parse('http://172.20.10.2:8000/coleta/protegida/');
  final response = await client.get(url, headers: cookie != null ? {'Cookie': cookie!} : {},);

  print('Status ${response.statusCode} e result ${response.body}');

}


Future<void> fetchData() async {
  try {
    // Substitua estas informações pelas suas credenciais e URL
    String username = 'sauloafoliveira';
    String password = 'qwerty09876';
    //Uri url = Uri.parse('http://www.ricoleta.app.br/coleta/animais/');
    Uri url = Uri.parse('http://172.20.10.2:8000/coleta/comlogin/');

    // Preparando a requisição
    final response = await client.post(
      url,
      headers: <String, String> {
        'Authorization': basicAuth(username, password),
        'username': username,
        'password': password,
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Content-Type': 'application/x-www-form-urlencoded'
      },

      // body: <String, String> {
      //   'username': username,
      //   'password': password
      // }
    );

    if (response.statusCode == 200) {
      print('Dados recebidos: ${response.body}');
      cookie = response.headers['set-cookie'];
      print('${response.headers} - $cookie');
    } else {
      print('Falha na requisição: ${response.statusCode}');
    }
  } finally {
   // client.close();
  }
}


 //const String BASE_URL = 'https://rico-cidts-39c8247ce62e.herokuapp.com';

const String BASE_URL = 'http://192.168.100.54:8000';

Future<dynamic> _login(String username, String password) {
  final uri = Uri.parse('$BASE_URL/coleta/login-session');
  return _client.post(uri, body: jsonEncode({
    'username': username,
    'password': password
  }),  headers: {
    'Content-Type': 'application/json',
  'Accept-Encoding': 'gzip, deflate, br',
  'Connection': 'keep-alive',

  },);
}


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


  static Map<String, dynamic> _defaults = {
    'user': {
      'nome' : 'Saulo Oliveira',
      'email': 'saulo@ifce.edu.br',
      'animais': [],
      'produtos' : []
    }
  };

  final Map<String, dynamic> _data;

  String get nome => user?['nome'] as String;
  String get email => user?['email'] as String;
  String get cpfOuCnpj => (user?['cpf'] ?? '') as String;

  List<dynamic> get animais => (_data['animais'] as List<dynamic>).map((e) => Animal(e, this)).toList();
  List<dynamic> get produtos => (_data['produtos'] as List<dynamic>).map((e) => Produto(e, this)).toList();


  Map<String, dynamic>? get user => (_data['user'] ?? {}) as Map<String, dynamic>;

  Produtor(this._data);
  Produtor.mock(): this(_defaults);

}