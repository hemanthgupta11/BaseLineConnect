import 'dart:typed_data';

class UserProfile{
  Uint8List photoDataList;
  String name;
  String email;
  String location;
  String job;
  String id;
  UserProfile({this.name,this.email,this.location,this.job,this.id});
  factory UserProfile.fromJson(Map<String,dynamic>json){
    return UserProfile(
      name:json['displayName'],
      email: json['mail'],
      location: json['officeLocation'],
      job: json['jobTitle'],
      id:json['id'],
      );
  }
}
class UserProfilesList{
  List<UserProfile> peersProfile;
  UserProfilesList({this.peersProfile});
  factory UserProfilesList.fromJson(Map<String,dynamic>parsedJson)
  {
    List<UserProfile>users=new List<UserProfile>();
    for(var i in parsedJson['value']){
    users.add(UserProfile.fromJson(i));
    }
    return UserProfilesList(peersProfile: users);
  }
}