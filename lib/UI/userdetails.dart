import 'package:baselineconnect/Models/userProfile.dart';
import 'package:baselineconnect/Services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:baselineconnect/Models/userProfile.dart' as user;
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  final LocalStorage storage;
  final AuthService authService;
  ProfilePage({this.authService, this.storage});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  user.UserProfile userDetails;
  user.UserProfile managerDetails;
  List<user.UserProfile> peersDetails;
  getData() async {
    userDetails = await widget.authService.getUserDetails();
    managerDetails = await widget.authService.getManagerDetails();
    peersDetails = await widget.authService.getPeersDetails();
    return peersDetails;
  }

  Widget pageloader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: new Border.all(color: Colors.grey[300]),
            ),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 12, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.grey,
                                    height: 8,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.grey,
                                    height: 8,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: 75.0,
                              height: 75.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: 8,
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: 8,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: 8,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              children: [0, 1, 2, 3]
                  .map(
                    (_) => Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
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
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildbody() {
    return FutureBuilder(
        future: getData(),
        builder: (context, sanphot) {
          if (sanphot.data == null) return pageloader();
          return ListView(
            children: <Widget>[
              Container(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 12, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${userDetails.name}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  Text(
                                    '${userDetails.job}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 75.0,
                                height: 75.0,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue[200],
                                          spreadRadius: 5)
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: MemoryImage(
                                            userDetails.photoDataList)))),
                          ],
                        ),
                      ),
                      Text(
                        'HI.......................................................................................................',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.blue[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.white,
                            ),
                            Text(
                              '${userDetails.location}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '26\u1d52 ',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                          Text(
                            'Sunny',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'My Team',
                  style: TextStyle(
                    color: Color.fromRGBO(17, 50, 102, 1),
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/user.jpg')))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${managerDetails.name}",
                            style: TextStyle(
                              color: Color.fromRGBO(17, 50, 102, 1),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${managerDetails.job}",
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: ListView.builder(
                  controller: new ScrollController(),
                  shrinkWrap: true,
                  itemCount: peersDetails.length,
                  itemBuilder: (context, i) {
                    return Container(
                        child: TeamMembers(
                      userDetails: peersDetails[i],
                    ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Logged in as'),
                      Text('${userDetails.email}'),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _buildbody(),
      bottomNavigationBar: Container(
        color: Colors.orange,
        child: FlatButton(
          child: Text('Logout'),
          onPressed: () async {
            await widget.authService.logout();
            LocalStorage stor = LocalStorage('Bookmarks');
            await stor.ready;
            LocalStorage dataStorage = LocalStorage('PeopleData');
            await dataStorage.ready;
            stor.deleteItem('Bookmarks');
            dataStorage.deleteItem('PeopleData');
            widget.storage.deleteItem('AuthData');
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
    );
  }
}

class TeamMembers extends StatelessWidget {
  final UserProfile userDetails;
  const TeamMembers({
    Key key,
    this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20),
        height: 60,
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                  color: Colors.black12,
                ),
                bottom: BorderSide(color: Colors.black12))),
        child: Padding(
          child: Row(
            children: <Widget>[
              Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (userDetails.photoDataList == null)
                              ? AssetImage('assets/user.jpg')
                              : MemoryImage(userDetails.photoDataList)))),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "${userDetails.name}",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      width: 230,
                    ),
                    Text(
                        (userDetails.job != null)
                            ? "${userDetails.job}"
                            : "member",
                        style: TextStyle(color: Colors.black.withOpacity(0.5)))
                  ],
                ),
              )
            ],
          ),
          padding: EdgeInsets.only(left: 20),
        ));
  }
}
