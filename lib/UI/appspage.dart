import 'package:baselineconnect/Services/services.dart';
import 'package:flutter/material.dart';

class AppsPage extends StatefulWidget{
  final List<PostDetails>details;
  AppsPage({this.details});
  @override
  AppsPageState createState()=>AppsPageState();
}
class AppsPageState extends State<AppsPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apps'),
      ),
      body:ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                onTap: (){
                },
                title: Row(
                  children: <Widget>[
                    Icon(Icons.folder,
                    color: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Doccuments'),
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                onTap: (){
                },
                title: Row(
                  children: <Widget>[
                    Icon(Icons.settings_system_daydream,
                    color: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ISO Forms'),
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                onTap: (){
                },
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person,
                    color: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Elogic'),
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                onTap: (){
                },
                title: Row(
                  children: <Widget>[
                    Icon(Icons.pages,
                    color: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Project GIS'),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}