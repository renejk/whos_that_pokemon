import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:whos_that_pokemon/app/data/models/pokemon.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.pokemones.length,
            itemBuilder: (context, index) {
              Pokemon pokemon = controller.pokemones[index];
              return ListTile(
                leading: Image.network(pokemon.url),
                title: Text(
                  'Pokemon ${pokemon.name}',
                ),
                trailing: controller.isCorrect.value
                    ? Image.network(
                        pokemon.gif,
                      )
                    : ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        child: Image.network(
                          pokemon.gif,
                        )),
              );
            },
          ),
        ),
      ),
    );
  }
}
