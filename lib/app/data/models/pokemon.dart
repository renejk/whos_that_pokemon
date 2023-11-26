class Pokemon {
  final int number;
  final String name;
  final String url;
  final String gif;

  Pokemon(this.number, this.name, this.url, this.gif);

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        json['id'],
        json['name'],
        json['sprites']['front_default'],
        json['gif'],
      );
}
