import 'dart:math';

import 'package:get/get.dart';
import 'package:whos_that_pokemon/app/data/services/poke_api.dart';

class GameController extends GetxController {
  final pokemones = [].obs;
  final pokemonSelected = ''.obs;
  final isCorrect = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
  }

  load() async {
    pokemones.value = await PorkeApi().getPokemonRandom(5);

    int indexRandom = Random().nextInt(5);
    pokemonSelected.value = pokemones[indexRandom].name;
  }

  check(String name) {
    if (name == pokemonSelected.value) {
      isCorrect.value = true;
    } else {
      isCorrect.value = false;
    }
  }
}
