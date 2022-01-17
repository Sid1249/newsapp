import 'package:flutter/material.dart';
import 'package:newsapp/models/newsModel.dart';
import 'package:newsapp/views/news_full_page.dart';
import 'package:timeago/timeago.dart' as timeago;


import '../themes.dart';

class NewsTile extends StatelessWidget {
  Articles? news;

  NewsTile({Key? key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>
                NewsFullView(
                  articles: news!,
                )));
      },
      child:
      Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            children: [

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(news!.source.name, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 19),),
                    SizedBox(height: 20,),
                    Text(news!.description.toString(), maxLines: 4,),
                    SizedBox(height: 10,),
                    Align(alignment: Alignment.bottomLeft,
                        child: Text('${timeago.format(DateTime.parse(
                            news!.publishedAt))}', style: TextStyle(
                            color: accentColor2,
                            fontWeight: FontWeight.w600),))
                  ],
                ),
              ),

              Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0)),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Image.network(
                      "${news!.urlToImage}",
                      height: 130.0,
                      width: 130.0,
                      fit: BoxFit.fill,
                    ),
                  )
              )


            ],
          ),
        ),
      )
      ,
    );
  }
}
