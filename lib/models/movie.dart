class Movie {
  int? id;
  String? judul;
  String? genre;
  String? tahun;
  String? durasi;
  String? episode;
  String? done;

  Movie(
      {this.id,
      this.judul,
      this.genre,
      this.tahun,
      this.durasi,
      this.episode,
      this.done});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['judul'] = judul;
    map['genre'] = genre;
    map['tahun'] = tahun;
    map['durasi'] = durasi;
    map['episode'] = episode;
    map['done'] = done;
    return map;
  }

  Movie.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.judul = map['judul'];
    this.genre = map['genre'];
    this.tahun = map['tahun'];
    this.durasi = map['durasi'];
    this.episode = map['episode'];
    this.done = map['done'];
  }
}
