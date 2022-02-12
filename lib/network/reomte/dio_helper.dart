import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://api.football-data.org/v2/',
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> getData({
    @required String? url,
    Map<String,dynamic>? query,
  })async{
    dio!.options.headers={
      'X-Auth-Token':'4ceaa787a6944252be5a3fd68390b05c',
    };

    return await dio!.get(url!,queryParameters: query);
  }
}