import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watchlist_1/screens/done.dart';
import 'package:watchlist_1/screens/listMovie.dart';
import 'package:watchlist_1/screens/tambahMovie.dart';

class WatchListMenu extends StatefulWidget {
  const WatchListMenu({super.key});

  @override
  State<WatchListMenu> createState() => _WatchListMenuState();
}

class _WatchListMenuState extends State<WatchListMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("WatchList Menu"),
            bottom: TabBar(tabs: [
              Tab(
                text: "List",
              ),
              Tab(
                text: "Done",
              )
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (() {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return TambahMovie();
              })));
            }),
            child: Icon(Icons.add),
          ),
          body: TabBarView(children: [WatchList(), DoneWatch()]),
        ));
  }
}
