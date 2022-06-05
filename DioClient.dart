
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:task4/models/LoginReq.dart';
import 'models/LoginRes.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';

  Future<LoginRes?> loginUser({required LoginReq req}) async{
    LoginRes? token;
    try{
      Response response  = await _dio.post('$_baseUrl/login', data: req.toJson());
      if(response.statusCode == 200) {
        token = LoginRes.fromJson(response.data);
      }
    }on DioError catch (error){
      if(error.response != null){
        developer.log('Dio error!');
        developer.log('STATUS: ${error.response?.statusCode}');
        developer.log('DATA: ${error.response?.data}');
        developer.log('HEADERS: ${error.response?.headers}');
        return null;
      }else{
        // Error due to setting up or sending the request
        developer.log('Error sending request!');
        developer.log(error.message);
        return null;
      }
    }
    return token;
  }
}