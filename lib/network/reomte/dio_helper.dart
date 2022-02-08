import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3/movie/550?api_key=41a0424812c65e1b0b9b142143bae463',
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> postData({
    @required String? url,
    @required Map<String,dynamic>? data,
    String? lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };

    return await dio!.post(url!,data: data!);
  }

  static Future<Response> getData({
    @required String? url,
    Map<String,dynamic>? query,
    String? lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };

    return await dio!.get(url!,queryParameters: query);
  }

  static Future<Response> putData({
    @required String? url,
    @required Map<String,dynamic>? data,
    String? lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };

    return await dio!.put(url!,data: data!);
  }
}