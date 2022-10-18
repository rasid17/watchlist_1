import 'package:flutter/material.dart';
import 'package:watchlist_1/database/db.dart';
import 'package:watchlist_1/models/movie.dart';

class EditMovie extends StatefulWidget {
  const EditMovie(
      {super.key,
      this.id,
      this.judul,
      this.genre,
      this.tahun,
      this.durasi,
      this.episode,
      this.done});
  final int? id;
  final String? judul;
  final String? genre;
  final String? tahun;
  final String? durasi;
  final String? episode;
  final String? done;

  @override
  State<EditMovie> createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  TextEditingController judul = TextEditingController();
  TextEditingController genre = TextEditingController();
  TextEditingController tahun = TextEditingController();
  TextEditingController durasi = TextEditingController();
  TextEditingController episode = TextEditingController();
  TextEditingController done = TextEditingController();
  DbHelper db = DbHelper();

  initDatabase() async {
    await db.database();
  }

  @override
  void initState() {
    judul.text = widget.judul!;
    genre.text = widget.genre!;
    tahun.text = widget.tahun!;
    durasi.text = widget.durasi!;
    episode.text = widget.episode!;
    done.text = widget.done!;
    initDatabase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Movie"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: judul,
                      decoration: InputDecoration(
                          labelText: 'Judul',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    )),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: genre,
                    decoration: InputDecoration(
                        labelText: 'Genre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: tahun,
                    decoration: InputDecoration(
                        labelText: 'Tahun',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: durasi,
                    decoration: InputDecoration(
                        labelText: 'Durasi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: episode,
                    decoration: InputDecoration(
                        labelText: 'Episode',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: (() async {
                        await editMovie();
                        Navigator.pop(context);
                      }),
                      child: Text("Edit Movie")),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> editMovie() async {
    await db.updateMovie(Movie(
        id: widget.id,
        judul: judul.text,
        genre: genre.text,
        tahun: tahun.text,
        durasi: tahun.text,
        episode: episode.text,
        done: widget.done));
  }
}
