class PlayerDetailsModel {
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

  PlayerDetailsModel(
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

  PlayerDetailsModel.fromJson(Map<String, dynamic> json) {
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
