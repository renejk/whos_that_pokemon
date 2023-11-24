import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:whos_that_pokemon/app/data/models/pokemon.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade400,
      //  appbar con el logo de la aplicacion
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.red.shade400,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.loading.value
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.pokemones.length,
                    itemBuilder: (context, index) {
                      Pokemon pokemon = controller.pokemones[index];
                      return Card(
                        child: ListTile(
                          leading: Container(
                            height: double.infinity,
                            width: 50,
                            color: Colors.blue,
                            child: Center(
                              child: Text(pokemon.number.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          title: Text(
                            pokemon.name,
                          ),
                          trailing: FutureBuilder(
                            future: controller.search(index),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data == true) {
                                  return Image.network(
                                    pokemon.gif,
                                  );
                                } else {
                                  return ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black, BlendMode.srcIn),
                                    child: Image.network(
                                      pokemon.gif,
                                    ),
                                  );
                                }
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              label: 'Anterior',
            ),
            // opcion para cazar pokemon
            BottomNavigationBarItem(
              icon: Icon(Icons.select_all_outlined),
              label: 'Capturar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_forward),
              label: 'Siguiente',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              controller.loadLess();
            } else if (index == 1) {
              controller.capture();
            } else {
              controller.loadMore();
            }
          }),
    );
  }
}
