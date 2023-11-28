import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  const GameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appbar con el nombre de la aplicacion
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red.shade400,
            elevation: 0,
            title: const Text('Who\'s that pokemon?'),
            leading: IconButton(
              onPressed: () => controller.back(),
              icon: const Icon(Icons.arrow_back),
            )),

        body: Obx(() => Column(
              children: [
                // mitad de la pantalla con la imagen en un stack de who's that pokemon
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      // imagen de who's that pokemon
                      Image.asset(
                        'assets/images/fondo_busqueda.jpg',
                        height: 600,
                        width: double.infinity,
                      ),

                      // imagen del pokemon
                      Align(
                        alignment: Alignment.centerLeft,
                        child: controller.pokemonSelectedName.value == ''
                            ? const SizedBox()
                            : controller.isCorrect.value
                                ? Image.network(
                                    controller.pokemonSelected.value,
                                    scale: 0.5,
                                    height: 200,
                                    width: 200,
                                  )
                                : ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black, BlendMode.srcIn),
                                    child: Image.network(
                                      controller.pokemonSelected.value,
                                      scale: 0.5,
                                      height: 200,
                                      width: 200,
                                    ),
                                  ),
                      ),
                      // contador con la variable durationGameSeconds en una esquina de la pantalla
                      controller.durationGameSeconds > 0
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 50, right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Obx(() => Text(
                                    controller.durationGameSeconds.value
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                // mitad de la pantalla con los botones con los nombres de los pokemones
                Expanded(
                    flex: 2,
                    child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        children: controller.pokemones.map((e) {
                          // haz un grid view con los botones

                          return Card(
                            child: ListTile(
                              leading: Container(
                                height: double.infinity,
                                width: 50,
                                color: Colors.blue,
                                child: Center(
                                  child: Text(e.number.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              title: Text(e.name),
                              onTap: () {
                                controller.check(e);
                              },
                            ),
                          );
                        }).toList()))
              ],
            )),
      ),
    );
  }
}
