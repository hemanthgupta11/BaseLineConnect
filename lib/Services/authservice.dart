import 'dart:convert';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:baselineconnect/Models/userProfile.dart';
import 'package:msgraph/msgraph.dart';

class AuthService {
  AadOAuth oauth;
  AuthService(this.oauth);
  Future<bool> login() async {
    bool islogin;
    try {
      await oauth.login();
      await oauth.getAccessToken();
      islogin = true;
    } catch (e) {
      islogin = false;
    }
    return islogin;
  }

  logout() async {
    await oauth.logout();
  }

  Future<UserProfile> getUserDetails() async {
    UserProfile userProfile;
    String token = await oauth.getAccessToken();
    try {
      var msGraph = MsGraph(token);
      var me = await msGraph.me.get();
      userProfile = UserProfile.fromJson(jsonDecode(me.body));
      var userPhoto = await msGraph.me.photo();
      userProfile.photoDataList = userPhoto.bodyBytes;
    } catch (e) {
      print('Error while Fetching User data');
    }
    return userProfile;
  }

  Future<UserProfile> getManagerDetails() async {
    UserProfile managerProfile;
    String token = await oauth.getAccessToken();
    try {
      var msGraph = MsGraph(token);
      var me = await msGraph.me.manager();
      managerProfile = UserProfile.fromJson(jsonDecode(me.body));
      var userPhoto = await msGraph.me.userPhoto(managerProfile.id);
      if (userPhoto != null) managerProfile.photoDataList = userPhoto.bodyBytes;
    } catch (e) {
      print('Error while Fetching Manager data');
    }
    return managerProfile;
  }

  Future<List<UserProfile>> getPeersDetails() async {
    UserProfilesList peersProfiles;
    String token = await oauth.getAccessToken();
    try {
      var msGraph = MsGraph(token);
      var me = await msGraph.me.people();
      peersProfiles = UserProfilesList.fromJson(jsonDecode(me.body));
      for (var peers in peersProfiles.peersProfile) {
        var userPhoto = await msGraph.me.userPhoto(peers.id);
        if (userPhoto != null) peers.photoDataList = userPhoto.bodyBytes;
      }
    } catch (e) {
      print('While FEtching Peers Data');
    }
    return peersProfiles.peersProfile;
  }

  Future<List<UserProfile>> getEmployeesDetails() async {
    UserProfilesList usersProfiles;
    String token = await oauth.getAccessToken();
    try {
      var msGraph = MsGraph(token);
      var me = await msGraph.me.users();
      usersProfiles = UserProfilesList.fromJson(jsonDecode(me.body));
      for (int index = 0; index < usersProfiles.peersProfile.length; index++) {
        var userPhoto =
            await msGraph.me.userPhoto(usersProfiles.peersProfile[index].id);
        if (userPhoto != null)
          usersProfiles.peersProfile[index].photoDataList = userPhoto.bodyBytes;
      }
    } catch (e) {
      print('While Fetching Usres Data');
    }
    return usersProfiles.peersProfile;
  }
}
