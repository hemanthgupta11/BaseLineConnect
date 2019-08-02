import 'dart:typed_data';

import 'package:baselineconnect/Services/authservice.dart';
import 'package:baselineconnect/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shimmer/shimmer.dart';

class EmployeesPage extends StatefulWidget {
  final List<PostDetails> details;
  final AuthService authService;
  EmployeesPage({this.details, this.authService});
  @override
  EmployeesPageState createState() => EmployeesPageState();
}

class EmployeesPageState extends State<EmployeesPage> {
  Widget pageloader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [0, 1, 2, 3, 4, 5]
              .map((_) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey,
                                    height: 8,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      color: Colors.grey,
                                      height: 8,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      color: Colors.grey,
                                      height: 8,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  getEmployeesDetails() async {
    LocalStorage datastorage = LocalStorage('PeopleData');
    await datastorage.ready;
    return datastorage.getItem('PeopleData');
  }

  Widget _buildbody() {
    Future<dynamic> usersDetails = getEmployeesDetails();
    return FutureBuilder<dynamic>(
        future: usersDetails,
        builder: (context, snapshot) {
          if (snapshot.data == null) return pageloader();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {},
                    title: Row(
                      children: <Widget>[
                        Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: (snapshot.data[i]['photoDataList'] ==
                                            null)
                                        ? AssetImage('assets/user.jpg')
                                        : MemoryImage(
                                            Uint8List.fromList(snapshot.data[i]
                                                    ['photoDataList']
                                                .cast<int>()),
                                          )))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${snapshot.data[i]['name']}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                (snapshot.data[i]['job'] == null)
                                    ? "Project Manager"
                                    : "${snapshot.data[i]['job']}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Construction  |  Brentwood",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Employees'),
            IconButton(
              onPressed: () async {
                List<dynamic> usersDetails=await getEmployeesDetails();
                showSearch(context: context,delegate: DataSearch(usersDetails:usersDetails ));
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
      ),
      body: _buildbody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: Icon(Icons.filter_list),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>
{
  var usersDetails;
  DataSearch({this.usersDetails});
  @override
  Widget buildLeading(BuildContext context)
  {
    return IconButton(onPressed: (){
      close(context,null);
    },
    icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
    progress: transitionAnimation,),
    );
  }
  @override
  List<Widget> buildActions(BuildContext context)
  {
    return [
      IconButton(icon: Icon(Icons.clear),
      onPressed: (){
        query='';
      },)
    ];
  }
  @override
  Widget buildResults(BuildContext context)
  {
    return Text('');
  }
  getSearchedUsers(String query)
  {
    List<dynamic>result=List<dynamic>();
    for(var val in usersDetails)
    {
      if(val['name'].toLowerCase().contains(query))
      result.add(val);
    }
    return result;
  }
  @override
  Widget buildSuggestions(BuildContext context)
  {
   // print(usersDetails);
    var userDetails=(query.isEmpty)?usersDetails:getSearchedUsers(query);
    return ListView.builder(
            shrinkWrap: true,
            itemCount: (query.isEmpty)?0:(userDetails==null)?0:userDetails.length,
            itemBuilder: (context, i) {
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {},
                    title: Row(
                      children: <Widget>[
                        Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: (userDetails[i]['photoDataList'] ==
                                            null)
                                        ? AssetImage('assets/user.jpg')
                                        : MemoryImage(
                                            Uint8List.fromList(userDetails[i]
                                                    ['photoDataList']
                                                .cast<int>()),
                                          )))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${userDetails[i]['name']}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                (userDetails[i]['job'] == null)
                                    ? "Project Manager"
                                    : "${userDetails[i]['job']}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Construction  |  Brentwood",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
  }
}