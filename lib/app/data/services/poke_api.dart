import 'dart:math';

import 'package:dio/dio.dart';
import 'package:whos_that_pokemon/app/data/models/pokemon.dart';

class PorkeApi {
  final Dio _dio = Dio();

  final String _url = 'https://pokeapi.co/api/v2/pokemon';

  final String _urlGif =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/';

  Future<List<Pokemon>> getPokemonRandom(int number) async {
    try {
      final List<Pokemon> pokemons = [];

      for (int i = 0; i < number; i++) {
        final int id = Random().nextInt(150);
        final Response response = await _dio.get('$_url/$id');
        response.data['gif'] = '$_urlGif/$id.gif';
        final Pokemon pokemon = Pokemon.fromJson(response.data);
        pokemons.add(pokemon);
      }
      return pokemons;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Pokemon>> getPokemons(int page) async {
    try {
      int init = (validatePage(page) * 6);
      final Response response = await _dio.get('$_url?limit=6&offset=$init');

      print('response.data: ${response.data}');
      final List<Pokemon> pokemons = [];
      for (var item in response.data['results']) {
        final Response response = await _dio.get(item['url']);
        response.data['gif'] = '$_urlGif/${response.data['id']}.gif';
        final Pokemon pokemon = Pokemon.fromJson(response.data);
        pokemons.add(pokemon);
      }
      return pokemons;
    } catch (e) {
      print(e);
      return [];
    }
  }

  validatePage(int page) {
    if (page < 0) {
      return 0;
    } else if (page > 25) {
      return 25;
    } else {
      return page;
    }
  }
}
