import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newsapp/models/newsModel.dart';
import 'package:newsapp/models/sourcsModel.dart';
import 'package:newsapp/themes.dart';
import 'package:newsapp/viewcontroller/news_viewController.dart';
import 'package:newsapp/viewcontroller/sourcesViewController.dart';
import 'package:newsapp/views/modal_sheeets/countrySelectModal.dart';
import 'package:newsapp/widgets/news_tile.dart';
import 'package:newsapp/widgets/no_results_screen.dart';
import 'package:newsapp/widgets/nowifi_screen.dart';

import 'modal_sheeets/sourceSelectModal.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  List<Articles?>? newslist;
  List<Articles?>? tempList = [];
  String countryCode = "in";

  List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  String chosenLocation = "India";
  List<Sources> selectedSources = [];

  var searchController = TextEditingController();

  StreamSubscription? subscription;
  bool _connected = true;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  var sortMap = {
    'publishedAt': "Newest",
    'popularity': 'Popular',
    'oldest': 'Oldest'
  };

  var sortKey = 'publishedAt';

  List<Sources?> sourcesList = [];

  Future<void> initConnectivity() async {
    late ConnectivityResult result;


    try {
      result = await _connectivity.checkConnectivity();
      setState(() {
        _connected = result != ConnectivityResult.none;
      });
    } on PlatformException catch (e) {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

  }

  void getNews(countryCode, sortBy) async {

    initConnectivity();

    setState(() {
      if(!_connected){
        setState(() {
          _loading = false;
        });
      }
    });

    if(_connected) {
      if (selectedSources.isNotEmpty) {
        String sourcesListString = "";
        selectedSources.forEach((element) {
          sourcesListString = sourcesListString + "${element.id},";
        });
        newslist =
        await NewsViewController.getAllTopHeadLinesFromSpecifcSources(
            sortBy: sortBy, sources: sourcesListString);
      } else {
        newslist = await NewsViewController.getAllTopHeadLines(
            sortBy: sortBy, countryCode: countryCode);
      }
    }

    setState(() {
      _loading = false;
    });
  }

  void getSorces() async {
    sourcesList =
        await SourcesViewController.getAllSources(countryCode: countryCode);
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getNews("in", 'publishedAt');
    getSorces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyNEWS'),
        backgroundColor: primaryColor,
        actions: [
          GestureDetector(
            onTap: () {
              CountrySelectModal().showCountrySelectModal(
                context,
                countryCode,
                countryCodeReturn: (countrycode, location) {
                  chosenLocation = location;
                  countryCode = countrycode;
                  getNews(countrycode, sortKey);
                  getSorces();
                  setState(() {
                    _loading = true;
                  });
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 19,
                      ),
                      Text(chosenLocation),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_alt_outlined),
        onPressed: () {
          SourceSelectModal().showSourceSelectModal(
              context, selectedSources, sourcesList, returnSources: (sources) {
            selectedSources = sources;
            getNews(countryCode, sortKey);
            setState(() {
              _loading = true;
            });
          });
        },
      ),
      body: SafeArea(
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search for news, topics...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          fillColor: accentColor2,
                          filled: true,
                        ),
                        onChanged: filterNews,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Top HeadLines",
                            style:
                                TextStyle(fontSize: 23, color: primaryColor2),
                          ),
                          Spacer(),
                          PopupMenuButton<String>(
                            onSelected: (String value) {
                              setState(() {
                                sortKey = value;

                                if (value != "oldest") {
                                  setState(() {
                                    newslist = [];
                                    _loading = true;
                                    getNews(countryCode, sortKey);
                                  });
                                } else {
                                  setState(() {
                                    _loading = true;
                                    getNews(countryCode, 'publishedAt');
                                  });
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text.rich(TextSpan(text: "Sort: ", children: [
                                  TextSpan(
                                      text: sortMap[sortKey],
                                      style: const TextStyle(
                                          color: primaryColor2,
                                          fontWeight: FontWeight.w600)),
                                ])),
                                const Icon(
                                  Icons.arrow_drop_down_sharp,
                                )
                              ],
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'popularity',
                                child: Text('Popular'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'publishedAt',
                                child: Text('Newest'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'oldest',
                                child: Text('Oldest'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: !_connected
                            ? NoWifiScreen(
                                retry: () {
                                  setState(() {
                                    _loading = true;
                                  });
                                  getNews(countryCode, sortKey);
                                  getSorces();
                                },
                              )
                            : tempList!.isEmpty &&
                                    searchController.text.length > 5
                                ? Center(child: NoResultsScreen())
                                : tempList!.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: tempList!.length,
                                        shrinkWrap: true,
                                        reverse: sortKey == 'oldest',
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              child: NewsTile(
                                                  news: tempList![index]));
                                        })
                                    : newslist!.isEmpty
                                        ? NoResultsScreen()
                                        : ListView.builder(
                                            itemCount: newslist!.length,
                                            shrinkWrap: true,
                                            reverse: sortKey == 'oldest',
                                            physics: ClampingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return NewsTile(
                                                  news: newslist![index]);
                                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void filterNews(String value) {
    tempList = [];
    if (value.length > 1) {
      newslist!.forEach((element) {
        if (element!.title
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()) ||
            element.description
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()) ||
            element.source.name
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase())) {
          tempList!.add(element);
        }
      });
    } else {
      tempList = [];
    }
    setState(() {});
  }
}
