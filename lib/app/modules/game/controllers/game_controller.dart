import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:whos_that_pokemon/app/data/models/pokemon.dart';
import 'package:whos_that_pokemon/app/data/services/guess_data.dart';
import 'package:whos_that_pokemon/app/data/services/poke_api.dart';
import 'package:whos_that_pokemon/app/routes/app_pages.dart';

class GameController extends GetxController {
  final pokemones = [].obs;
  final pokemonSelected = ''.obs;
  final pokemonSelectedName = ''.obs;
  final isCorrect = false.obs;
  final timerToReset = 0.obs;
  final durationGameSeconds = 0.obs;
  late Timer _timerGame;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await load();
  }

  back() {
    _timerGame.cancel();
    Get.offAllNamed(Routes.HOME);
  }

  Future load() async {
    pokemones.value = await PorkeApi().getPokemonRandom(5);

    int indexRandom = Random().nextInt(5);

    pokemonSelected.value = pokemones[indexRandom].url;
    pokemonSelectedName.value = pokemones[indexRandom].name;
    durationGameSeconds.value = 5;
    durationGame();
  }

  check(Pokemon pokemon) {
    if (pokemon.name == pokemonSelectedName.value) {
      GuessSingleton().addPokemon(pokemon.number);
      isCorrect.value = true;
      _timerGame.cancel();
      resetQuest();
    } else {
      isCorrect.value = false;
      load();
    }
  }

  // duracion de seleccion 5 segundos
  //  si no se selecciona ninguno se resetea el tablero

  durationGame() {
    _timerGame = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (durationGameSeconds.value == 0) {
        timer.cancel();

        await load();
        isCorrect.value = false;
      } else {
        // menos 1 segundo y se actualiza el valor
        durationGameSeconds.value--;
      }
    });
  }

  //  resetear tablero
  resetQuest() {
    timerToReset.value = 60;

    Timer.periodic(const Duration(microseconds: 60), (timer) async {
      if (timerToReset.value == 0) {
        timer.cancel();

        await load();
        isCorrect.value = false;
      } else {
        // menos 1 segundo y se actualiza el valor
        timerToReset.value--;
      }
    });
  }
}
