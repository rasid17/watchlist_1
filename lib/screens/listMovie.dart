import 'package:flutter/material.dart';
import 'package:watchlist_1/database/db.dart';
import 'package:watchlist_1/models/movie.dart';
import 'package:watchlist_1/screens/editMovie.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
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
                          margin: const EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                            onPressed: () async {
                              await db.updateMovieDone(movie, "Sudah");
                              setState(() {
                                getMovie();
                              });
                            },
                            child: const Text("Selesai"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                              onPressed: (() {
                                hapusMovie(movie, index);
                              }),
                              child: Text("Hapus")),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 5),
                            child: ElevatedButton(
                                onPressed: (() async {
                                  Navigator.pop(context);
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return EditMovie(
                                      id: movie.id,
                                      judul: movie.judul,
                                      genre: movie.genre,
                                      tahun: movie.tahun,
                                      durasi: movie.durasi,
                                      episode: movie.durasi,
                                      done: movie.done,
                                    );
                                  })));
                                }),
                                child: Text("Edit")))
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
    var list = await db.getAllMovieNotDone();
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
