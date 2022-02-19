import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://api.football-data.org/v2/',
          receiveDataWhenStatusError: true,
          headers: {
            'X-Auth-Token':'4ceaa787a6944252be5a3fd68390b05c',
          }
        ),

    );
  }


  static Future<Response> getAllMatches() async {
    return dio!.get("/matches");
  }

  static Future<Response> getLeagueTeams({@required int? leagueID}) async {
    return dio!.get("/competitions/$leagueID/teams");
  }

  static Future<Response> getMatchDetails({@required int? matchID}) async {
    return dio!.get("/matches/$matchID");
  }

  static Future<Response> getLeagueTopScorers({@required int? leagueID}) async {
    return dio!.get(
        "/competitions/$leagueID/scorers",
        queryParameters: {'limit':500}
    );
  }
}