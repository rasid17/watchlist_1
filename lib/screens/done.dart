import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watchlist_1/database/db.dart';

import '../models/movie.dart';

class DoneWatch extends StatefulWidget {
  const DoneWatch({super.key});

  @override
  State<DoneWatch> createState() => _DoneWatchState();
}

class _DoneWatchState extends State<DoneWatch> {
  DbHelper db = DbHelper();
  List<Movie> listMovie = [];
  bool isSelected = false;

  initDatabase() async {
    await db.database();
    getMovie();
  }

  @override
  void initState() {
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Movie movie = listMovie[index];
              return Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Judul: ${movie.judul}"),
                    Text("Genre: ${movie.genre}"),
                    Text("Tahun: ${movie.tahun}"),
                    Text("Durasi: ${movie.durasi}"),
                    Text("Episode: ${movie.episode}"),
                    Text("Status: ${movie.done}"),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                              onPressed: (() {
                                hapusMovie(movie, index);
                              }),
                              child: Text("Hapus")),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
            itemCount: listMovie.length));
  }

  Future<void> getMovie() async {
    var list = await db.getAllMovieDone();
    setState(() {
      listMovie.clear();

      list!.forEach((element) {
        listMovie.add(Movie.fromMap(element));
      });
    });
  }

  Future<void> hapusMovie(Movie movie, int index) async {
    if (movie.id != null) {
      await db.hapusMovie(movie.id ?? 0);
    }
    setState(() {
      getMovie();
    });
  }
}
