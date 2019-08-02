import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:baselineconnect/Services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  AadOAuth oauth;
  bool islogin = false;
  bool initialized = false;
  AuthService authService;
  LocalStorage storage;
  Widget buildLoginPage() {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: (Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login with microsoft Account'),
              RaisedButton(
                onPressed: () async {
                  bool islogin = await authService.login();
                  Map<String, dynamic> token = Map();
                  token['token'] = await authService.oauth.getAccessToken();
                  if (islogin) {
                    storage.setItem('AuthData', token);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          settings: const RouteSettings(name: '/home'),
                          builder: (context) => HomePage(
                                authService: authService,
                              )),
                    );
                  }
                },
                child: Text('Login'),
              )
            ],
          ),
        )));
  }
  getitemdata() async {
    String azureClientId = "329f1d77-260b-448e-a2f6-e954266085c2";
    String azureTennant = "19d81766-4830-42d1-9fc3-df8b962a1cf5";
    final Config config = new Config(azureTennant, azureClientId,
        "openid profile offline_access", "com.example.login://redirect");
    oauth = new AadOAuth(config);
    authService = new AuthService(oauth);
    storage = LocalStorage('AuthData');
    return storage.ready;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getitemdata(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (!initialized) {
            var accessToken = storage.getItem('AuthData');
            if (accessToken != null)
              return HomePage(
                authService: authService,
                storage: storage,
              );
          }
          return buildLoginPage();
        });
  }
}
