import 'package:baselineconnect/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class BookmarksPage extends StatefulWidget {
  final List<String> bookmarkList;
  final List<PostDetails> details;
  BookmarksPage({this.details, this.bookmarkList});
  @override
  BookmarksPageState createState() => BookmarksPageState();
}

class BookmarksPageState extends State<BookmarksPage> {
  Widget _buildbody() {
    LocalStorage storage = LocalStorage('Bookmarks');
    return FutureBuilder(
        future: storage.ready,
        builder: (context, snapshot) {
          var bookmarks = storage.getItem('Bookmarks');
          return ListView.builder(
            shrinkWrap: true,
            itemCount: (bookmarks == null) ? 0 : bookmarks.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                      onTap: () {},
                      title: Row(
                        children: <Widget>[
                          Icon(Icons.book),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${bookmarks[index]}',
                              ),
                            ),
                          ),
                        ],
                      )),
                  Divider(),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: _buildbody(),
    );
  }
}
