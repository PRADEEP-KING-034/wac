 class Usermodel{
  final String name;
  final String uid;
  final String profilepic;
  final bool isonline;
  final String phonenumber;
  final List<String> groupId;

  Usermodel({
    required this.name,
    required this.uid,
    required this.profilepic,
    required this.isonline,
    required this.phonenumber,
    required this.groupId});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "profilepic": profilepic,
      "isonline": isonline,
      "phonenumber": phonenumber,
      "groupId": groupId,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      name: map["name"]??'',
      uid: map["uid"]??'',
      profilepic: map["profilepic"]??'',
      isonline: map["isonline"]?? false,
      phonenumber: map["phonenumber"]??'',
      groupId: List<String>.from(map['groupId']),
    );
  }
 }
