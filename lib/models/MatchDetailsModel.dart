
class MatchDetailsModel {
  MatchDetailsModel({
      this.head2head, 
      this.match,});

  MatchDetailsModel.fromJson(dynamic json) {
    head2head = json['head2head'] != null ? Head2head.fromJson(json['head2head']) : null;
    match = json['match'] != null ? Match.fromJson(json['match']) : null;
  }
  Head2head? head2head;
  Match? match;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (head2head != null) {
      map['head2head'] = head2head?.toJson();
    }
    if (match != null) {
      map['match'] = match?.toJson();
    }
    return map;
  }

}


class Match {
  Match({
      this.id, 
      this.competition, 
      this.season, 
      this.utcDate, 
      this.status, 
      this.venue, 
      this.matchday, 
      this.stage, 
      this.group, 
      this.lastUpdated, 
      this.odds, 
      this.score, 
      this.homeTeam, 
      this.awayTeam, 
      this.referees,});

  Match.fromJson(dynamic json) {
    id = json['id'];
    competition = json['competition'] != null ? Competition.fromJson(json['competition']) : null;
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    utcDate = json['utcDate'];
    status = json['status'];
    venue = json['venue'];
    matchday = json['matchday'];
    stage = json['stage'];
    group = json['group'];
    lastUpdated = json['lastUpdated'];
    odds = json['odds'] != null ? Odds.fromJson(json['odds']) : null;
    score = json['score'] != null ? Score.fromJson(json['score']) : null;
    homeTeam = json['homeTeam'] != null ? HomeTeam.fromJson(json['homeTeam']) : null;
    awayTeam = json['awayTeam'] != null ? AwayTeam.fromJson(json['awayTeam']) : null;
    if (json['referees'] != null) {
      referees = [];
      json['referees'].forEach((v) {
        referees?.add(Referees.fromJson(v));
      });
    }
  }
  int? id;
  Competition? competition;
  Season? season;
  String? utcDate;
  String? status;
  String? venue;
  int? matchday;
  String? stage;
  dynamic group;
  String? lastUpdated;
  Odds? odds;
  Score? score;
  HomeTeam? homeTeam;
  AwayTeam? awayTeam;
  List<Referees>? referees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (competition != null) {
      map['competition'] = competition?.toJson();
    }
    if (season != null) {
      map['season'] = season?.toJson();
    }
    map['utcDate'] = utcDate;
    map['status'] = status;
    map['venue'] = venue;
    map['matchday'] = matchday;
    map['stage'] = stage;
    map['group'] = group;
    map['lastUpdated'] = lastUpdated;
    if (odds != null) {
      map['odds'] = odds?.toJson();
    }
    if (score != null) {
      map['score'] = score?.toJson();
    }
    if (homeTeam != null) {
      map['homeTeam'] = homeTeam?.toJson();
    }
    if (awayTeam != null) {
      map['awayTeam'] = awayTeam?.toJson();
    }
    if (referees != null) {
      map['referees'] = referees?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Referees {
  Referees({
      this.id, 
      this.name, 
      this.role, 
      this.nationality,});

  Referees.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    nationality = json['nationality'];
  }
  int? id;
  String? name;
  String? role;
  dynamic nationality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role'] = role;
    map['nationality'] = nationality;
    return map;
  }

}


class AwayTeam {
  AwayTeam({
      this.id, 
      this.name,});

  AwayTeam.fromJson(dynamic json) {
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


class HomeTeam {
  HomeTeam({
      this.id, 
      this.name,});

  HomeTeam.fromJson(dynamic json) {
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


class Score {
  Score({
      this.winner, 
      this.duration, 
      this.fullTime, 
      this.halfTime, 
      this.extraTime, 
      this.penalties,});

  Score.fromJson(dynamic json) {
    winner = json['winner'];
    duration = json['duration'];
    fullTime = json['fullTime'] != null ? FullTime.fromJson(json['fullTime']) : null;
    halfTime = json['halfTime'] != null ? HalfTime.fromJson(json['halfTime']) : null;
    extraTime = json['extraTime'] != null ? ExtraTime.fromJson(json['extraTime']) : null;
    penalties = json['penalties'] != null ? Penalties.fromJson(json['penalties']) : null;
  }
  dynamic winner;
  String? duration;
  FullTime? fullTime;
  HalfTime? halfTime;
  ExtraTime? extraTime;
  Penalties? penalties;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winner'] = winner;
    map['duration'] = duration;
    if (fullTime != null) {
      map['fullTime'] = fullTime?.toJson();
    }
    if (halfTime != null) {
      map['halfTime'] = halfTime?.toJson();
    }
    if (extraTime != null) {
      map['extraTime'] = extraTime?.toJson();
    }
    if (penalties != null) {
      map['penalties'] = penalties?.toJson();
    }
    return map;
  }

}


class Penalties {
  Penalties({
      this.homeTeam, 
      this.awayTeam,});

  Penalties.fromJson(dynamic json) {
    homeTeam = json['homeTeam'];
    awayTeam = json['awayTeam'];
  }
  dynamic homeTeam;
  dynamic awayTeam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['homeTeam'] = homeTeam;
    map['awayTeam'] = awayTeam;
    return map;
  }

}


class ExtraTime {
  ExtraTime({
      this.homeTeam, 
      this.awayTeam,});

  ExtraTime.fromJson(dynamic json) {
    homeTeam = json['homeTeam'];
    awayTeam = json['awayTeam'];
  }
  dynamic homeTeam;
  dynamic awayTeam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['homeTeam'] = homeTeam;
    map['awayTeam'] = awayTeam;
    return map;
  }

}


class HalfTime {
  HalfTime({
      this.homeTeam, 
      this.awayTeam,});

  HalfTime.fromJson(dynamic json) {
    homeTeam = json['homeTeam'];
    awayTeam = json['awayTeam'];
  }
  dynamic homeTeam;
  dynamic awayTeam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['homeTeam'] = homeTeam;
    map['awayTeam'] = awayTeam;
    return map;
  }

}


class FullTime {
  FullTime({
      this.homeTeam, 
      this.awayTeam,});

  FullTime.fromJson(dynamic json) {
    homeTeam = json['homeTeam'];
    awayTeam = json['awayTeam'];
  }
  dynamic homeTeam;
  dynamic awayTeam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['homeTeam'] = homeTeam;
    map['awayTeam'] = awayTeam;
    return map;
  }

}


class Odds {
  Odds({
      this.msg,});

  Odds.fromJson(dynamic json) {
    msg = json['msg'];
  }
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
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
      this.name, 
      this.area,});

  Competition.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
  }
  int? id;
  String? name;
  Area? area;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (area != null) {
      map['area'] = area?.toJson();
    }
    return map;
  }

}


class Area {
  Area({
      this.name, 
      this.code, 
      this.ensignUrl,});

  Area.fromJson(dynamic json) {
    name = json['name'];
    code = json['code'];
    ensignUrl = json['ensignUrl'];
  }
  String? name;
  String? code;
  String? ensignUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['code'] = code;
    map['ensignUrl'] = ensignUrl;
    return map;
  }

}


class Head2head {
  Head2head({
      this.numberOfMatches, 
      this.totalGoals, 
      this.homeTeam, 
      this.awayTeam,});

  Head2head.fromJson(dynamic json) {
    numberOfMatches = json['numberOfMatches'];
    totalGoals = json['totalGoals'];
    homeTeam = json['homeTeam'] != null ? HomeTeamMatches.fromJson(json['homeTeam']) : null;
    awayTeam = json['awayTeam'] != null ? AwayTeamMatches.fromJson(json['awayTeam']) : null;
  }
  int? numberOfMatches;
  int? totalGoals;
  HomeTeamMatches? homeTeam;
  AwayTeamMatches? awayTeam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['numberOfMatches'] = numberOfMatches;
    map['totalGoals'] = totalGoals;
    if (homeTeam != null) {
      map['homeTeam'] = homeTeam?.toJson();
    }
    if (awayTeam != null) {
      map['awayTeam'] = awayTeam?.toJson();
    }
    return map;
  }

}


class AwayTeamMatches {
  AwayTeamMatches({
      this.id, 
      this.name, 
      this.wins, 
      this.draws, 
      this.losses,});

  AwayTeamMatches.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    wins = json['wins'];
    draws = json['draws'];
    losses = json['losses'];
  }
  int? id;
  String? name;
  int? wins;
  int? draws;
  int? losses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['wins'] = wins;
    map['draws'] = draws;
    map['losses'] = losses;
    return map;
  }

}


class HomeTeamMatches {
  HomeTeamMatches({
      this.id, 
      this.name, 
      this.wins, 
      this.draws, 
      this.losses,});

  HomeTeamMatches.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    wins = json['wins'];
    draws = json['draws'];
    losses = json['losses'];
  }
  int? id;
  String? name;
  int? wins;
  int? draws;
  int? losses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['wins'] = wins;
    map['draws'] = draws;
    map['losses'] = losses;
    return map;
  }

}