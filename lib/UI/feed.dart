import 'package:baselineconnect/Models/userProfile.dart';
import 'package:baselineconnect/Services/authservice.dart';
import 'package:baselineconnect/Services/services.dart';
import 'package:baselineconnect/UI/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class CompanyFeed extends StatefulWidget {
  final List<String> bookmarkList;
  final LocalStorage storage;
  final List<PostDetails> details;
  final AuthService authService;
  CompanyFeed(
      {this.details, this.authService, this.storage, this.bookmarkList});
  @override
  CompanyFeedState createState() => CompanyFeedState();
}

class CompanyFeedState extends State<CompanyFeed> {
  List<UserProfile> peopleProfile;
  Widget _buildHorizontalfeed() {
    return Column(
      children: <Widget>[
        Container(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, index) {
              try {
                return Card(
                    child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: AssetImage('${widget.details[0].imagePath}'),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: MediaQuery.of(context).size.height,
                  child: ListTile(
                    onTap: () {},
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INNOVATOR',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.details[0].title}',
                          style: TextStyle(
                            fontSize: 24,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.message,
                                color: Colors.white,
                              ),
                              Text(
                                ' 129      212',
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
              } catch (e) {
                return CircularProgressIndicator();
              }
            },
            itemCount: 5,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Base',
            style: TextStyle(fontSize: 24, letterSpacing: 0),
          ),
          Text(
            'line',
            style: TextStyle(
                fontSize: 24,
                color: Colors.yellow,
                fontStyle: FontStyle.italic,
                letterSpacing: 0),
          ),
          Text(
            'Connect',
            style: TextStyle(fontSize: 18, letterSpacing: 0),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('assets/user.jpg')))),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          authService: widget.authService,
                          storage: widget.storage,
                        )));
          },
        )
      ],
    );
  }

  Widget _buildTextLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            ' My Company',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
          Text(
            'View all',
            style: TextStyle(
              fontSize: 16,
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreDsciplines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: Text('Explore Disciplines',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: 12.0),
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ListTile(
                        onTap: () {},
                        title: Container(
                          height: 70,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'ADMINISTRATION',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ListTile(
                        onTap: () {},
                        title: Container(
                          height: 70,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'DESIGN BUILD',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: 5,
            ),
          ),
        )
      ],
    );
  }
  jsonEncodable(UserProfile item){
    Map<String,dynamic> m=new Map();
    m['photoDataList']=item.photoDataList;
    m['name']=item.name;
    m['email']=item.email;
    m['location']=item.location;
    m['job']=item.job;
    m['id']=item.id;
    return m;
  }
  getitemdata()async{
    LocalStorage datastorage=LocalStorage('PeopleData');
    await datastorage.ready;
    if(datastorage.getItem('PeopleData')==null)
    {
    peopleProfile=await widget.authService.getEmployeesDetails();
    var peoples=peopleProfile.map((val){
      return jsonEncodable(val);
    }).toList();
    datastorage.setItem('PeopleData',peoples);
    }
  }
  @override
  Widget build(BuildContext context) {
    getitemdata();
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            _buildAppBar(),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                children: <Widget>[
                  _buildHorizontalfeed(),
                  _buildTextLine(),
                ],
              ),
            ),
            VerticalFeed(
              bookmarkList: widget.bookmarkList,
            ),
            VerticalFeed(
              bookmarkList: widget.bookmarkList,
            ),
            VerticalFeed(
              bookmarkList: widget.bookmarkList,
            ),
            _buildExploreDsciplines(),
            VerticalFeed(
              bookmarkList: widget.bookmarkList,
            ),
            VerticalFeed(
              bookmarkList: widget.bookmarkList,
            ),
          ]),
        )
      ],
    );
  }
}

class VerticalFeed extends StatefulWidget {
  final List<String> bookmarkList;
  VerticalFeed({this.bookmarkList});
  @override
  VerticalFeedState createState() => VerticalFeedState();
}

class VerticalFeedState extends State<VerticalFeed> {
  LocalStorage storage = LocalStorage('Bookmarks');
  Widget _selectPopup() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("Bookmark"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Cancel"),
        ),
      ],
      initialValue: 1,
      onSelected: (value) async {
        await storage.ready;
        if (value == 1) {
          setState(() {
            widget.bookmarkList.add("Barry School Named Man of the Year");
            storage.setItem('Bookmarks', widget.bookmarkList);
          });
          print(widget.bookmarkList);
        }
      },
      icon: Icon(Icons.list),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Card(
        child: Container(
          height: 244,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/user.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'DESIGN BUILD',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      'Barry School Named Man of the Year',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '09/27/20112',
                            style: TextStyle(color: Colors.grey),
                          ),
                          _selectPopup(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
