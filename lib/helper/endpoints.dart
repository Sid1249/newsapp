

import 'package:newsapp/secreat.dart';

class EndPoints {

  static String _baseUrl = "https://newsapi.org";

  static String get get_allTopHeadlines =>
      _baseUrl + '/v2/top-headlines?sortBy={0}&country={1}&apiKey=6641cdd4d1164378a8539d47b7cc6791';

  static String get get_allTopHeadlinesFromSources =>
      _baseUrl + '/v2/top-headlines?sortBy={0}&sources={1}&apiKey=6641cdd4d1164378a8539d47b7cc6791';

  static String get get_all_sources =>
      _baseUrl + '/v2/top-headlines/sources?country={0}&apiKey=6641cdd4d1164378a8539d47b7cc6791';


}