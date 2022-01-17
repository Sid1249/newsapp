
import 'dart:convert';

import 'package:newsapp/helper/endpoints.dart';
import 'package:newsapp/helper/http_helpers.dart';
import 'package:newsapp/models/sourcsModel.dart';


class SourcesViewController {

  static Future<List<Sources?>> getAllSources({required String countryCode}) async {
    try {
      var response =
      await HttpHelpers.getAnonymousRequest(EndPoints.get_all_sources.replaceAll('{0}',countryCode ));
      if (response.statusCode == 201 || response.statusCode == 200) {
        var decodeJson = jsonDecode(utf8.decode(response.bodyBytes));

        SourcesModel sources = SourcesModel.fromJson(decodeJson);


        return sources.sources;

      }else{
        return [];
      }
    } catch (ex) {
      print("excceeption = $ex");
      return [];
    }

  }
}