
class LeagueStandingModel {
  LeagueStandingModel({
      this.competition, 
      this.season, 
      this.standings,});

  LeagueStandingModel.fromJson(dynamic json) {
    competition = json['competition'] != null ? Competition.fromJson(json['competition']) : null;
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    if (json['standings'] != null) {
      standings = [];
      json['standings'].forEach((v) {
        standings?.add(Standings.fromJson(v));
      });
    }
  }
  Competition? competition;
  Season? season;
  List<Standings>? standings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (competition != null) {
      map['competition'] = competition?.toJson();
    }
    if (season != null) {
      map['season'] = season?.toJson();
    }
    if (standings != null) {
      map['standings'] = standings?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Standings {
  Standings({
      this.stage, 
      this.type, 
      this.group, 
      this.table,});

  Standings.fromJson(dynamic json) {
    stage = json['stage'];
    type = json['type'];
    group = json['group'];
    if (json['table'] != null) {
      table = [];
      json['table'].forEach((v) {
        table?.add(Table.fromJson(v));
      });
    }
  }
  String? stage;
  String? type;
  dynamic group;
  List<Table>? table;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stage'] = stage;
    map['type'] = type;
    map['group'] = group;
    if (table != null) {
      map['table'] = table?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Table {
  Table({
      this.position, 
      this.team, 
      this.playedGames, 
      this.form, 
      this.won, 
      this.draw, 
      this.lost, 
      this.points, 
      this.goalsFor, 
      this.goalsAgainst, 
      this.goalDifference,});

  Table.fromJson(dynamic json) {
    position = json['position'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    playedGames = json['playedGames'];
    form = json['form'];
    won = json['won'];
    draw = json['draw'];
    lost = json['lost'];
    points = json['points'];
    goalsFor = json['goalsFor'];
    goalsAgainst = json['goalsAgainst'];
    goalDifference = json['goalDifference'];
  }
  int? position;
  Team? team;
  int? playedGames;
  dynamic form;
  int? won;
  int? draw;
  int? lost;
  int? points;
  int? goalsFor;
  int? goalsAgainst;
  int? goalDifference;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['position'] = position;
    if (team != null) {
      map['team'] = team?.toJson();
    }
    map['playedGames'] = playedGames;
    map['form'] = form;
    map['won'] = won;
    map['draw'] = draw;
    map['lost'] = lost;
    map['points'] = points;
    map['goalsFor'] = goalsFor;
    map['goalsAgainst'] = goalsAgainst;
    map['goalDifference'] = goalDifference;
    return map;
  }

}


class Team {
  Team({
      this.id, 
      this.name, 
      this.crestUrl,});

  Team.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    crestUrl = json['crestUrl'];
  }
  int? id;
  String? name;
  String? crestUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['crestUrl'] = crestUrl;
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