import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
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
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
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
                                future: controller.search(pokemon.number),
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
                    FloatingActionButton(
                        onPressed: () {
                          controller.capture();
                        },
                        child: Image.asset(
                          'assets/icons/pokebola.png',
                        ))
                  ],
                ),
        ),
        bottomNavigationBar: Obx(() {
          return NumberPaginator(
            config: const NumberPaginatorUIConfig(
              buttonSelectedBackgroundColor: Colors.white,
              buttonSelectedForegroundColor: Colors.red,
              buttonUnselectedBackgroundColor: Colors.red,
              buttonUnselectedForegroundColor: Colors.white,
            ),
            showPrevButton: controller.page.value > 0,
            showNextButton: controller.page.value < 25,
            numberPages: 25,
            onPageChange: (int index) {
              controller.loadPage(index);
            },
          );
        }));
  }
}
