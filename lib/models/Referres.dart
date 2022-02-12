/// referees : [{"id":11615,"name":"Adam Nunn","role":"ASSISTANT_REFEREE_N1","nationality":"England"},{"id":73363,"name":"Nick Hopton","role":"ASSISTANT_REFEREE_N2","nationality":null},{"id":11556,"name":"David Coote","role":"FOURTH_OFFICIAL","nationality":"England"},{"id":11494,"name":"Stuart Attwell","role":"REFEREE","nationality":"England"},{"id":23568,"name":"Jarred Gillett","role":"VIDEO_ASSISANT_REFEREE_N1","nationality":"Australia"},{"id":11424,"name":"Neil Davies","role":"VIDEO_ASSISANT_REFEREE_N2","nationality":"England"}]

class Referees {
  Referees({this.referees,});

  Referees.fromJson(dynamic json) {
    if (json['referees'] != null) {
      referees = [];
      json['referees'].forEach((v) {
        referees?.add(Referees.fromJson(v));
      });
    }
  }
  List<Referees>? referees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (referees != null) {
      map['referees'] = referees?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 11615
/// name : "Adam Nunn"
/// role : "ASSISTANT_REFEREE_N1"
/// nationality : "England"

class RefereesData {
  RefereesData({
      this.id, 
      this.name, 
      this.role, 
      this.nationality,});

  RefereesData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    nationality = json['nationality'];
  }
  int? id;
  String? name;
  String? role;
  String? nationality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role'] = role;
    map['nationality'] = nationality;
    return map;
  }

}