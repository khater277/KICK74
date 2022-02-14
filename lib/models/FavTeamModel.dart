/// id : 45
/// leagueID : 2021
/// name : "asd"
/// image : "asd"

class FavTeamModel {
  FavTeamModel({
      this.id, 
      this.leagueID, 
      this.name, 
      this.image,});

  FavTeamModel.fromJson(dynamic json) {
    id = json['id'];
    leagueID = json['leagueID'];
    name = json['name'];
    image = json['image'];
  }
  int? id;
  int? leagueID;
  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['leagueID'] = leagueID;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}