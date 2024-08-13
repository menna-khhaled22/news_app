import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';

class ApiManager{

  // https://newsapi.org/v2/everything?q=bitcoin&apiKey=30d1be203a7344e7a2ff7b50c1f22663

  static Future<SourceResponse?> getSources() async{
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesApi ,
    {
      'apiKey' : '30d1be203a7344e7a2ff7b50c1f22663'
    });
    var response = await http.get(url);
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    }catch (e){
      throw(e);
    }
  }

  static Future<NewsResponse?> getNewsBySourceId(String sourceId) async{
    Uri url = Uri.https(ApiConstants.baseUrl,ApiConstants.newsApi , {
      'apiKey' : '30d1be203a7344e7a2ff7b50c1f22663',
      'sources' : sourceId

    });
    var response = await http.get(url);
    try {
      return NewsResponse.fromJson(jsonDecode(response.body));
    }catch(e){
      throw e;
    }


  }
}