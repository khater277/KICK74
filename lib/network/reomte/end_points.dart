import 'package:flutter/cupertino.dart';

String ALL_MATCHES = "http://api.football-data.org/v2/matches";

String LEAGUE_TEAMS({@required leagueID}){
  return "https://api.football-data.org/v2/competitions/$leagueID/teams";
}