class NewsModel {
  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
  var status;
  late final int totalResults;
  late final List<Articles> articles;

  NewsModel.fromJson(Map<dynamic, dynamic> json){
    status = json['status'];
    totalResults = json['totalResults'];
    articles = List.from(json['articles']).map((e)=>Articles.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['status'] = status;
    _data['totalResults'] = totalResults;
    _data['articles'] = articles.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Articles {
  Articles({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    this.content,
  });
  late final Source source;
  var author;
  var title;
  var description;
  var url;
  var urlToImage;
  var publishedAt;
  var content;

  Articles.fromJson(Map<dynamic, dynamic> json){
    source = Source.fromJson(json['source']);
    author = null;
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = null;
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['source'] = source.toJson();
    _data['author'] = author;
    _data['title'] = title;
    _data['description'] = description;
    _data['url'] = url;
    _data['urlToImage'] = urlToImage;
    _data['publishedAt'] = publishedAt;
    _data['content'] = content;
    return _data;
  }
}

class Source {
  Source({
    this.id,
    required this.name,
  });
  var id;
  var name;

  Source.fromJson(Map<dynamic, dynamic> json){
    id = null;
    name = json['name'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}