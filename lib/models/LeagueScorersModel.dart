
class LeagueScorersModel {
  LeagueScorersModel({
      this.count, 
      this.filters, 
      this.competition, 
      this.season, 
      this.scorers,});

  LeagueScorersModel.fromJson(dynamic json) {
    count = json['count'];
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    competition = json['competition'] != null ? Competition.fromJson(json['competition']) : null;
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    if (json['scorers'] != null) {
      scorers = [];
      json['scorers'].forEach((v) {
        scorers?.add(Scorers.fromJson(v));
      });
    }
  }
  int? count;
  Filters? filters;
  Competition? competition;
  Season? season;
  List<Scorers>? scorers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (filters != null) {
      map['filters'] = filters?.toJson();
    }
    if (competition != null) {
      map['competition'] = competition?.toJson();
    }
    if (season != null) {
      map['season'] = season?.toJson();
    }
    if (scorers != null) {
      map['scorers'] = scorers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Scorers {
  Scorers({
      this.player, 
      this.team, 
      this.numberOfGoals,});

  Scorers.fromJson(dynamic json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    numberOfGoals = json['numberOfGoals'];
  }
  Player? player;
  Team? team;
  int? numberOfGoals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (player != null) {
      map['player'] = player?.toJson();
    }
    if (team != null) {
      map['team'] = team?.toJson();
    }
    map['numberOfGoals'] = numberOfGoals;
    return map;
  }

}


class Team {
  Team({
      this.id, 
      this.name,});

  Team.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}


class Player {
  Player({
      this.id, 
      this.name, 
      this.firstName, 
      this.lastName, 
      this.dateOfBirth, 
      this.countryOfBirth, 
      this.nationality, 
      this.position, 
      this.shirtNumber, 
      this.lastUpdated,});

  Player.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    countryOfBirth = json['countryOfBirth'];
    nationality = json['nationality'];
    position = json['position'];
    shirtNumber = json['shirtNumber'];
    lastUpdated = json['lastUpdated'];
  }
  int? id;
  String? name;
  String? firstName;
  dynamic lastName;
  String? dateOfBirth;
  String? countryOfBirth;
  String? nationality;
  String? position;
  dynamic shirtNumber;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['dateOfBirth'] = dateOfBirth;
    map['countryOfBirth'] = countryOfBirth;
    map['nationality'] = nationality;
    map['position'] = position;
    map['shirtNumber'] = shirtNumber;
    map['lastUpdated'] = lastUpdated;
    return map;
  }

}


class Season {
  Season({
      this.id, 
      this.startDate, 
      this.endDate, 
      this.currentMatchday, 
      this.winner,});

  Season.fromJson(dynamic json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    currentMatchday = json['currentMatchday'];
    winner = json['winner'];
  }
  int? id;
  String? startDate;
  String? endDate;
  int? currentMatchday;
  dynamic winner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['currentMatchday'] = currentMatchday;
    map['winner'] = winner;
    return map;
  }

}


class Competition {
  Competition({
      this.id, 
      this.area, 
      this.name, 
      this.code, 
      this.plan, 
      this.lastUpdated,});

  Competition.fromJson(dynamic json) {
    id = json['id'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    name = json['name'];
    code = json['code'];
    plan = json['plan'];
    lastUpdated = json['lastUpdated'];
  }
  int? id;
  Area? area;
  String? name;
  String? code;
  String? plan;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (area != null) {
      map['area'] = area?.toJson();
    }
    map['name'] = name;
    map['code'] = code;
    map['plan'] = plan;
    map['lastUpdated'] = lastUpdated;
    return map;
  }

}


class Area {
  Area({
      this.id, 
      this.name,});

  Area.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}


class Filters {
  Filters({
      this.limit,});

  Filters.fromJson(dynamic json) {
    limit = json['limit'];
  }
  int? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['limit'] = limit;
    return map;
  }

}