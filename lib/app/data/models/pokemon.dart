class Pokemon {
  final String name;
  final String url;
  final String gif;

  Pokemon(this.name, this.url, this.gif);

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      json['name'],
      json['sprites']['front_default'],
      json['gif'],
    );
  }
}
