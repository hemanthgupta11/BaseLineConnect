class PostDetails{
  String name;
  String title;
  String description;
  String imagePath;
  PostDetails({this.name,this.title,this.description,this.imagePath});
  factory PostDetails.fromJson(Map<String,dynamic>json){
    return PostDetails(
      name:json['name'],
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
      );
  }
}
class PostDetailsList{
  List<PostDetails> details;
  PostDetailsList({this.details});
  fromJson(List<dynamic> parsedJson){
    List<PostDetails> details=new List<PostDetails>();
    details=parsedJson.map((i)=>PostDetails.fromJson(i)).toList();
    return details;
  }
}