import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whos_that_pokemon/app/data/services/guess_data.dart';
import 'package:whos_that_pokemon/app/data/services/poke_api.dart';
import 'package:whos_that_pokemon/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final pokemones = [].obs;
  final loading = false.obs;
  final page = 0.obs;
  int maxPage = 25;
  int minPage = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
  }

  load() async {
    loading.value = true;
    pokemones.value = await PorkeApi().getPokemons(0);

    print(pokemones.length);
    loading.value = false;
  }

  loadPage(int index) async {
    loading.value = true;
    page.value = index;
    pokemones.value = await PorkeApi().getPokemons(page.value);
    loading.value = false;
  }

  // buscar en guess data

  search(int index) async {
    bool result = false;
    result = GuessSingleton().isPokemon(index);
    print(GuessSingleton().pokemons);
    return result;
  }

  // capturar  pokemones
  capture() async {
    Get.offNamed(Routes.GAME);
  }
}
