import 'dart:convert';
import 'package:baselineconnect/Services/authservice.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:baselineconnect/UI/appspage.dart';
import 'package:baselineconnect/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'bookmarkspage.dart';
import 'employeespage.dart';
import 'feed.dart';

class HomePage extends StatefulWidget {
  final AuthService authService;
  final LocalStorage storage;
  HomePage({this.authService, this.storage});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PostDetailsList datalist = new PostDetailsList();
  List<PostDetails> details;
  List<String> bookmarkList = new List<String>();
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/data.json').then((dat) {
      setState(() {
        details = datalist.fromJson(json.decode(dat));
      });
    });
  }
  Widget buildbody()
  {
    return TabBarView(
          children: <Widget>[
            CompanyFeed(
                details: details,
                authService: widget.authService,
                storage: widget.storage,
                bookmarkList: bookmarkList),
            EmployeesPage(
              details: details,
              authService: widget.authService,
            ),
            AppsPage(details: details),
            BookmarksPage(
              details: details,
              bookmarkList: bookmarkList,
            ),
          ],
        );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: buildbody(),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.people), text: 'Employees'),
              Tab(icon: Icon(Icons.apps), text: 'Apps'),
              Tab(icon: Icon(Icons.bookmark), text: 'Bookmarks'),
            ],
          ),
        ),
      ),
    );
  }
}
