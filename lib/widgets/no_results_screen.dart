import 'package:flutter/material.dart';
import 'package:newsapp/themes.dart';

class NoResultsScreen extends StatelessWidget {
  NoResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SizedBox(height: MediaQuery.of(context).size.height/5),

        Image.asset(
          'assets/images/newspaper.png',
          width: 70,
          height: 70,
          color: accentColor2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("No Results Found"),
        ),
      ],
    );
  }
}
