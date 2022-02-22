import 'package:kick74/models/LeagueTeamsModel.dart';

class FavouriteTeamModel {
  FavouriteTeamModel({
    this.leagueID,
    this.team,
  });

  FavouriteTeamModel.fromJson(dynamic json) {
    leagueID = json['leagueID'];
    team = json['team'];
  }
  int? leagueID;
  Teams? team;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leagueID'] = leagueID;
    if (team != null) {
      map['team'] = team?.toJson();
    }
    return map;
  }
}
