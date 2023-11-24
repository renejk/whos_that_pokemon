import 'package:dio/dio.dart';
import 'package:whos_that_pokemon/app/data/models/pokemon.dart';

class PorkeApi {
  final Dio _dio = Dio();

  final String _url = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Pokemon>> getPokemonRandom(int number) async {
    // try {
    final List<Pokemon> pokemons = [];

    for (int i = 0; i < number; i++) {
      final int id = (1 + (i * 151) / number).round();
      final Response response = await _dio.get('$_url/$id');
      response.data['gif'] =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/$id.gif';
      final Pokemon pokemon = Pokemon.fromJson(response.data);
      pokemons.add(pokemon);
    }
    return pokemons;
    // } catch (e) {
    //   print(e);
    //   return [];
    // }
  }
}
