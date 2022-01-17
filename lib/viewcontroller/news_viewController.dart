
import 'dart:convert';

import 'package:get/get.dart';
import 'package:newsapp/helper/endpoints.dart';
import 'package:newsapp/helper/http_helpers.dart';
import 'package:newsapp/models/newsModel.dart';

import '../secreat.dart';

class NewsViewController {

  static Future<List<Articles?>> getAllTopHeadLines({required String countryCode, required sortBy}) async {
    try {
      var response =
      await HttpHelpers.getAnonymousRequest(EndPoints.get_allTopHeadlines.replaceAll('{0}',sortBy ).replaceAll('{1}',countryCode ));
      if (response.statusCode == 201 || response.statusCode == 200) {
        var decodeJson = jsonDecode(utf8.decode(response.bodyBytes));
        print("here decoded json = $decodeJson");

        NewsModel newsModel = NewsModel.fromJson(decodeJson);

        print("here news model = $newsModel");

        return newsModel.articles;

      }else{
        return [];
      }
    } catch (ex) {
      print("excceeption = $ex");
      return [];
    }

  }


  static Future<List<Articles?>> getAllTopHeadLinesFromSpecifcSources({required sortBy, required String sources}) async {
    try {
      var response =
      await HttpHelpers.getAnonymousRequest(EndPoints.get_allTopHeadlinesFromSources.replaceAll('{0}',sortBy ).replaceAll('{1}',sources ));
      if (response.statusCode == 201 || response.statusCode == 200) {
        var decodeJson = jsonDecode(utf8.decode(response.bodyBytes));
        print("here decoded json = $decodeJson");

        NewsModel newsModel = NewsModel.fromJson(decodeJson);

        print("here news model = $newsModel");

        return newsModel.articles;

      }else{
        return [];
      }
    } catch (ex) {
      print("excceeption = $ex");
      return [];
    }

  }
}