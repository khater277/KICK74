import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.football-data.org/v2/',
          receiveDataWhenStatusError: true,
          //connectTimeout: 20 * 1000,
          //receiveTimeout: 20 * 1000,
          headers: {
            'X-Auth-Token': '4ceaa787a6944252be5a3fd68390b05c',
          }),
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
    return dio!.get("/competitions/$leagueID/scorers",
        queryParameters: {'limit': 500});
  }

  static Future<Response> getTeamDetails({@required int? teamID}) async {
    return dio!.get("/teams/$teamID");
  }


  static Future<Response> getPlayerAllDetails({
    @required int? playerID,
    @required int? leagueID,
    @required String? startDate,
    @required String? endDate,
  }) async {
    return dio!.get("/players/$playerID/matches", queryParameters: {
      'status': 'FINISHED',
      'dateFrom': startDate,
      'dateTo': endDate,
      'competitions': leagueID,
    });
  }

  static Future<Response> getLeagueStanding({@required int? leagueID}) async {
    return dio!.get("/competitions/$leagueID/standings");
  }

  static Future<Response> getTeamAllMatches({
    @required int? teamID,
    @required String? startDate,
    @required String? endDate,
  }) async {
    return dio!.get("/teams/$teamID/matches",queryParameters: {
      'dateFrom': startDate,
      'dateTo': endDate,
    });
  }
}
