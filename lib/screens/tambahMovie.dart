import 'package:flutter/material.dart';
import 'package:watchlist_1/database/db.dart';
import 'package:watchlist_1/models/movie.dart';

class TambahMovie extends StatefulWidget {
  final Movie? movie;
  const TambahMovie({super.key, this.movie});

  @override
  State<TambahMovie> createState() => _TambahMovieState();
}

class _TambahMovieState extends State<TambahMovie> {
  TextEditingController judul = TextEditingController();
  TextEditingController genre = TextEditingController();
  TextEditingController tahun = TextEditingController();
  TextEditingController durasi = TextEditingController();
  TextEditingController episode = TextEditingController();
  TextEditingController done = TextEditingController(text: "Belum");
  DbHelper db = DbHelper();

  initDatabase() async {
    await db.database();
  }

  @override
  void initState() {
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Movie"),
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
                        if (judul!.text.isEmpty) {
                          showDialogJudul(BuildContext context) {
                            Widget ok = TextButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            AlertDialog alertDialogKosong = AlertDialog(
                              title: Text("PERINGATAN!"),
                              content: Text("Judul masih kosong!"),
                              actions: [ok],
                            );
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return alertDialogKosong;
                                }));
                          }

                          print("Alert Kosong");
                          showDialogJudul(context);
                        } else {
                          await upMovie();
                          Navigator.pop(context);
                        }
                      }),
                      child: Text("Tambah Movie")),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> upMovie() async {
    print(judul.text);
    await db.tambahMovie(Movie(
        judul: judul.text,
        genre: genre.text,
        tahun: tahun.text,
        durasi: durasi.text,
        episode: episode.text,
        done: done.text));
  }
}
