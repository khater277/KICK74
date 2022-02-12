class LeagueTeamsModel {
  LeagueTeamsModel({
      this.count, 
      this.competition, 
      this.season, 
      this.teams,});

  LeagueTeamsModel.fromJson(dynamic json) {
    count = json['count'];
    competition = json['competition'] != null ? Competition.fromJson(json['competition']) : null;
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    if (json['teams'] != null) {
      teams = [];
      json['teams'].forEach((v) {
        teams?.add(Teams.fromJson(v));
      });
    }
  }
  int? count;
  Competition? competition;
  Season? season;
  List<Teams>? teams;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (competition != null) {
      map['competition'] = competition?.toJson();
    }
    if (season != null) {
      map['season'] = season?.toJson();
    }
    if (teams != null) {
      map['teams'] = teams?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Teams {
  Teams({
      this.id, 
      this.area, 
      this.name, 
      this.shortName, 
      this.tla, 
      this.crestUrl, 
      this.address, 
      this.phone, 
      this.website, 
      this.email, 
      this.founded, 
      this.clubColors, 
      this.venue, 
      this.lastUpdated,});

  Teams.fromJson(dynamic json) {
    id = json['id'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crestUrl = json['crestUrl'];
    address = json['address'];
    phone = json['phone'];
    website = json['website'];
    email = json['email'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    lastUpdated = json['lastUpdated'];
  }
  int? id;
  Area? area;
  String? name;
  String? shortName;
  String? tla;
  String? crestUrl;
  String? address;
  String? phone;
  String? website;
  String? email;
  int? founded;
  String? clubColors;
  String? venue;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (area != null) {
      map['area'] = area?.toJson();
    }
    map['name'] = name;
    map['shortName'] = shortName;
    map['tla'] = tla;
    map['crestUrl'] = crestUrl;
    map['address'] = address;
    map['phone'] = phone;
    map['website'] = website;
    map['email'] = email;
    map['founded'] = founded;
    map['clubColors'] = clubColors;
    map['venue'] = venue;
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