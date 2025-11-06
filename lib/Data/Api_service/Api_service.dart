import 'dart:convert';
import 'package:groceries_app/Data/Api_service/Api_Response.dart';
import 'package:groceries_app/Data/Get%20Storage/Auth_Storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


class ApiServices {

  static Logger logger = Logger();

  //============================ Get Data =====================================
 static Future<ApiResponse> getData(Uri url) async {
    try {
      //-------------- request sent to server -----------
      final response = await http.get(url);
        logger.i("Login Status code : ${response.statusCode}");
        logger.i("signup Status code : ${response.statusCode}");
      //---------- response check ---------
      if (response.statusCode == 200 || response.statusCode ==201) {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseBody: decodedData,
        );
      }
      else {
        return ApiResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseBody: null,
        );
      }
    } catch (e) {
      return ApiResponse(
        statusCode: -1,
        isSuccess: false,
        responseBody: null,
        message: e.toString(),
      );
    }
  }

  //============================ Post Data =====================================
  static Future<ApiResponse> postData(
    Uri url,
    Map<String, dynamic> requestBody,
  ) async {
    try {
      final token = AuthStorage.accessToken;

      //--------------- logger request url check ----------
      loggerRequest(url);

      //-------------- request sent to server -----------
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "token": token ?? " "},

        body: jsonEncode(requestBody),
      );

      //--------------- logger response ----------
      loggerResponse(url,response.body,response.statusCode);


    //---------- response check ---------
      if (response.statusCode == 201 || response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        logger.i("Login Status code : ${response.statusCode}");
        logger.i("signUp Status code : ${response.statusCode}");
        return ApiResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseBody: decodedData,
          message: decodedData["message"],
        );
      } else {
        return ApiResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseBody: null,
        );
      }
    } catch (e) {
      return ApiResponse(
        statusCode: -1,
        isSuccess: false,
        responseBody: null,
        message: e.toString(),
      );
    }
  }


  //==================== logger request ===============
 static loggerRequest(url){
   return logger.i("Request url: $url");
 }
  //==================== logger response===============
  static loggerResponse(url,body,statusCode){
    return logger.i("Response url: $url \n Response body : $body \n Response status code : $statusCode");
  }
}
