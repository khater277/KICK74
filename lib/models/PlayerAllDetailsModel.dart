class PlayerAllDetailsModel {
  int? count;
  Filters? filters;
  Player? player;
  List<Matches>? matches;

  PlayerAllDetailsModel({this.count, this.filters, this.player, this.matches});

  PlayerAllDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["filters"] is Map) {
      filters =
          json["filters"] == null ? null : Filters.fromJson(json["filters"]);
    }
    if (json["player"] is Map) {
      player = json["player"] == null ? null : Player.fromJson(json["player"]);
    }
    if (json["matches"] is List) {
      matches = json["matches"] == null
          ? null
          : (json["matches"] as List).map((e) => Matches.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["count"] = count;
    if (filters != null) {
      data["filters"] = filters!.toJson();
    }
    if (player != null) {
      data["player"] = player!.toJson();
    }
    if (matches != null) {
      data["matches"] = matches!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  int? id;
  Competition? competition;
  Season? season;
  String? utcDate;
  String? status;
  int? matchday;
  String? stage;
  dynamic group;
  String? lastUpdated;
  Odds? odds;
  Score? score;
  HomeTeam? homeTeam;
  AwayTeam? awayTeam;
  List<Referees>? referees;

  Matches(
      {this.id,
      this.competition,
      this.season,
      this.utcDate,
      this.status,
      this.matchday,
      this.stage,
      this.group,
      this.lastUpdated,
      this.odds,
      this.score,
      this.homeTeam,
      this.awayTeam,
      this.referees});

  Matches.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["competition"] is Map) {
      competition = json["competition"] == null
          ? null
          : Competition.fromJson(json["competition"]);
    }
    if (json["season"] is Map) {
      season = json["season"] == null ? null : Season.fromJson(json["season"]);
    }
    if (json["utcDate"] is String) {
      utcDate = json["utcDate"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["matchday"] is int) {
      matchday = json["matchday"];
    }
    if (json["stage"] is String) {
      stage = json["stage"];
    }
    group = json["group"];
    if (json["lastUpdated"] is String) {
      lastUpdated = json["lastUpdated"];
    }
    if (json["odds"] is Map) {
      odds = json["odds"] == null ? null : Odds.fromJson(json["odds"]);
    }
    if (json["score"] is Map) {
      score = json["score"] == null ? null : Score.fromJson(json["score"]);
    }
    if (json["homeTeam"] is Map) {
      homeTeam =
          json["homeTeam"] == null ? null : HomeTeam.fromJson(json["homeTeam"]);
    }
    if (json["awayTeam"] is Map) {
      awayTeam =
          json["awayTeam"] == null ? null : AwayTeam.fromJson(json["awayTeam"]);
    }
    if (json["referees"] is List) {
      referees = json["referees"] == null
          ? null
          : (json["referees"] as List)
              .map((e) => Referees.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (competition != null) {
      data["competition"] = competition!.toJson();
    }
    if (season != null) {
      data["season"] = season!.toJson();
    }
    data["utcDate"] = utcDate;
    data["status"] = status;
    data["matchday"] = matchday;
    data["stage"] = stage;
    data["group"] = group;
    data["lastUpdated"] = lastUpdated;
    if (odds != null) {
      data["odds"] = odds!.toJson();
    }
    if (score != null) {
      data["score"] = score!.toJson();
    }
    if (homeTeam != null) {
      data["homeTeam"] = homeTeam!.toJson();
    }
    if (awayTeam != null) {
      data["awayTeam"] = awayTeam!.toJson();
    }
    if (referees != null) {
      data["referees"] = referees!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Referees {
  int? id;
  String? name;
  String? role;
  dynamic nationality;

  Referees({this.id, this.name, this.role, this.nationality});

  Referees.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["role"] is String) {
      role = json["role"];
    }
    nationality = json["nationality"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["role"] = role;
    data["nationality"] = nationality;
    return data;
  }
}

class AwayTeam {
  int? id;
  String? name;

  AwayTeam({this.id, this.name});

  AwayTeam.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class HomeTeam {
  int? id;
  String? name;

  HomeTeam({this.id, this.name});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Score {
  String? winner;
  String? duration;
  FullTime? fullTime;
  HalfTime? halfTime;
  ExtraTime? extraTime;
  Penalties? penalties;

  Score(
      {this.winner,
      this.duration,
      this.fullTime,
      this.halfTime,
      this.extraTime,
      this.penalties});

  Score.fromJson(Map<String, dynamic> json) {
    if (json["winner"] is String) {
      winner = json["winner"];
    }
    if (json["duration"] is String) {
      duration = json["duration"];
    }
    if (json["fullTime"] is Map) {
      fullTime =
          json["fullTime"] == null ? null : FullTime.fromJson(json["fullTime"]);
    }
    if (json["halfTime"] is Map) {
      halfTime =
          json["halfTime"] == null ? null : HalfTime.fromJson(json["halfTime"]);
    }
    if (json["extraTime"] is Map) {
      extraTime = json["extraTime"] == null
          ? null
          : ExtraTime.fromJson(json["extraTime"]);
    }
    if (json["penalties"] is Map) {
      penalties = json["penalties"] == null
          ? null
          : Penalties.fromJson(json["penalties"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["winner"] = winner;
    data["duration"] = duration;
    if (fullTime != null) {
      data["fullTime"] = fullTime!.toJson();
    }
    if (halfTime != null) {
      data["halfTime"] = halfTime!.toJson();
    }
    if (extraTime != null) {
      data["extraTime"] = extraTime!.toJson();
    }
    if (penalties != null) {
      data["penalties"] = penalties!.toJson();
    }
    return data;
  }
}

class Penalties {
  dynamic homeTeam;
  dynamic awayTeam;

  Penalties({this.homeTeam, this.awayTeam});

  Penalties.fromJson(Map<String, dynamic> json) {
    homeTeam = json["homeTeam"];
    awayTeam = json["awayTeam"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["homeTeam"] = homeTeam;
    data["awayTeam"] = awayTeam;
    return data;
  }
}

class ExtraTime {
  dynamic homeTeam;
  dynamic awayTeam;

  ExtraTime({this.homeTeam, this.awayTeam});

  ExtraTime.fromJson(Map<String, dynamic> json) {
    homeTeam = json["homeTeam"];
    awayTeam = json["awayTeam"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["homeTeam"] = homeTeam;
    data["awayTeam"] = awayTeam;
    return data;
  }
}

class HalfTime {
  int? homeTeam;
  int? awayTeam;

  HalfTime({this.homeTeam, this.awayTeam});

  HalfTime.fromJson(Map<String, dynamic> json) {
    if (json["homeTeam"] is int) {
      homeTeam = json["homeTeam"];
    }
    if (json["awayTeam"] is int) {
      awayTeam = json["awayTeam"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["homeTeam"] = homeTeam;
    data["awayTeam"] = awayTeam;
    return data;
  }
}

class FullTime {
  int? homeTeam;
  int? awayTeam;

  FullTime({this.homeTeam, this.awayTeam});

  FullTime.fromJson(Map<String, dynamic> json) {
    if (json["homeTeam"] is int) {
      homeTeam = json["homeTeam"];
    }
    if (json["awayTeam"] is int) {
      awayTeam = json["awayTeam"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["homeTeam"] = homeTeam;
    data["awayTeam"] = awayTeam;
    return data;
  }
}

class Odds {
  String? msg;

  Odds({this.msg});

  Odds.fromJson(Map<String, dynamic> json) {
    if (json["msg"] is String) {
      msg = json["msg"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["msg"] = msg;
    return data;
  }
}

class Season {
  int? id;
  String? startDate;
  String? endDate;
  int? currentMatchday;

  Season({this.id, this.startDate, this.endDate, this.currentMatchday});

  Season.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["startDate"] is String) {
      startDate = json["startDate"];
    }
    if (json["endDate"] is String) {
      endDate = json["endDate"];
    }
    if (json["currentMatchday"] is int) {
      currentMatchday = json["currentMatchday"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["startDate"] = startDate;
    data["endDate"] = endDate;
    data["currentMatchday"] = currentMatchday;
    return data;
  }
}

class Competition {
  int? id;
  String? name;

  Competition({this.id, this.name});

  Competition.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Player {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? countryOfBirth;
  String? nationality;
  String? position;
  dynamic shirtNumber;
  String? lastUpdated;

  Player(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.countryOfBirth,
      this.nationality,
      this.position,
      this.shirtNumber,
      this.lastUpdated});

  Player.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if (json["lastName"] is String) {
      lastName = json["lastName"];
    }
    if (json["dateOfBirth"] is String) {
      dateOfBirth = json["dateOfBirth"];
    }
    if (json["countryOfBirth"] is String) {
      countryOfBirth = json["countryOfBirth"];
    }
    if (json["nationality"] is String) {
      nationality = json["nationality"];
    }
    if (json["position"] is String) {
      position = json["position"];
    }
    shirtNumber = json["shirtNumber"];
    if (json["lastUpdated"] is String) {
      lastUpdated = json["lastUpdated"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["dateOfBirth"] = dateOfBirth;
    data["countryOfBirth"] = countryOfBirth;
    data["nationality"] = nationality;
    data["position"] = position;
    data["shirtNumber"] = shirtNumber;
    data["lastUpdated"] = lastUpdated;
    return data;
  }
}

class Filters {
  String? permission;
  String? dateFrom;
  String? dateTo;
  List<String>? status;
  List<int>? competitions;
  int? limit;

  Filters(
      {this.permission,
      this.dateFrom,
      this.dateTo,
      this.status,
      this.competitions,
      this.limit});

  Filters.fromJson(Map<String, dynamic> json) {
    if (json["permission"] is String) {
      permission = json["permission"];
    }
    if (json["dateFrom"] is String) {
      dateFrom = json["dateFrom"];
    }
    if (json["dateTo"] is String) {
      dateTo = json["dateTo"];
    }
    if (json["status"] is List) {
      status =
          json["status"] == null ? null : List<String>.from(json["status"]);
    }
    if (json["competitions"] is List) {
      competitions = json["competitions"] == null
          ? null
          : List<int>.from(json["competitions"]);
    }
    if (json["limit"] is int) {
      limit = json["limit"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["permission"] = permission;
    data["dateFrom"] = dateFrom;
    data["dateTo"] = dateTo;
    if (status != null) {
      data["status"] = status;
    }
    if (competitions != null) {
      data["competitions"] = competitions;
    }
    data["limit"] = limit;
    return data;
  }
}
