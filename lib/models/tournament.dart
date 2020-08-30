class Tournament{
  String coverUrl;
  String name;
  String gameName;

  Tournament(this.coverUrl, this.name, this.gameName);


  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      json['cover_url'],
      json['name'],
      json['game_name'],
    );
  }
}