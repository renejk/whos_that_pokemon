class GuessSingleton {
  static final GuessSingleton _singleton = GuessSingleton._internal();

  factory GuessSingleton() {
    return _singleton;
  }

  GuessSingleton._internal();

  List<int> pokemons = [];

  void addPokemon(int id) {
    pokemons.add(id);
  }

  void removePokemon(int id) {
    pokemons.remove(id);
  }

  bool isPokemon(int id) {
    return pokemons.contains(id);
  }
}
