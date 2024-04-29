import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ricoletta/models.dart';

// RICO URLS
const String GET_ANIMAIS = 'http://192.168.100.54:8000/coleta/animais';
const String GET_ANIMAL = 'http://192.168.100.54:8000/coleta/animal/{id}';

const String GET_PRODUTO = '';
const String GET_PRODUTOS = '';

http.Client _client = http.Client();

class RicoService {

  static const String BASE_URL = 'https://www.ricoleta.app.br';
  static const String ANIMALS_URL = BASE_URL +  '/coleta/animais/';
  static const String PRODUTOS_URL = BASE_URL +  '/coleta/produtos/';

  final int? userId;

  RicoService(this.userId);

  Future<dynamic> _fetchItem(String url,  dynamic Function(dynamic item)? mapper) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (mapper != null) {
          return mapper(jsonResponse);
        }

        return jsonResponse;

      } else {
        throw Exception('Failed to load item from ($url).');
      }
    } catch (e) {
      throw Exception('Failed to load item: $e');
    }
  }

  Future<List<dynamic>> _fetchItems(
      String url, dynamic Function(dynamic item)? mapper) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        final jsonResponse = json.decode(response.body) as List<dynamic>;

        if (mapper != null) {
          return jsonResponse.map(mapper).toList();
        }

        return jsonResponse;

      } else {
        throw Exception('Failed to load items from $url');
      }
    } catch (e) {
      throw Exception('Failed to load items: $e.');
    }
  }

  ///////
  Future<List<dynamic>> fetchAnimals() async {
    final animalsByIdUrl = ANIMALS_URL + (userId ?? '').toString();
    return _fetchItems(animalsByIdUrl, (item) => Animal.fromJSON(item));
  }

  Future<List<dynamic>> fetchProducts() async {
    final animalsByIdUrl = ANIMALS_URL + (userId ?? '').toString();

    return _fetchItems(animalsByIdUrl, (item) => Animal.fromJSON(item));
  }

  Future<List<dynamic>> fetchAnimal(int? animalId) async {
    final animalsByIdUrl = ANIMALS_URL + (userId ?? '').toString();
    return _fetchItems(animalsByIdUrl, (item) => Animal.fromJSON(item));
  }
}
