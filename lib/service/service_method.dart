import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import 'dart:convert';

Future request(url,{formData})async{
  try{
    //print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){

      response = await dio.get(url);
    }else{
      response = await dio.post(url,data:formData);
    }
    if(response.statusCode==200){
      print('-----请求成功-----');
//      var data = json.decode(response.toString());
      return response;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}