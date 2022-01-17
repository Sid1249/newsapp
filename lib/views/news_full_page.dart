import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/newsModel.dart';
import 'package:newsapp/themes.dart';

class NewsFullView extends StatelessWidget {
  Articles articles;

  NewsFullView({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor, leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.32,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Stack(
                  children: [

                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,

                        child: Image.network(
                          articles.urlToImage, fit: BoxFit.fitWidth,)),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            articles.title,
                            style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,),
                            textAlign: TextAlign.left,

                          ),
                        )),
                  ],
                ),

              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(articles.source.name, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 19),),
                    SizedBox(height: 5,),

                    Text(getFormattedDateString(
                        DateTime.parse(articles.publishedAt))),
                    SizedBox(height: 20,),

                    Text(articles.content ?? articles.description),
                    SizedBox(height: 20,),

                    GestureDetector(
                      onTap: () {
                        _launchURL(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Seee Full Story", style: TextStyle(
                              color: primaryColor),),
                          Icon(Icons.navigate_next, color: primaryColor,)
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDateString(DateTime date) {
    return DateFormat().format(date);
  }


  void _launchURL(BuildContext context) async {
    try {
      await launch(
        articles.url,
        customTabsOption: CustomTabsOption(
          toolbarColor: Theme
              .of(context)
              .primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Theme
              .of(context)
              .primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
