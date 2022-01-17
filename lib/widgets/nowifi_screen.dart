import 'package:flutter/material.dart';

import '../themes.dart';

class NoWifiScreen extends StatelessWidget {
  Function() retry;
  NoWifiScreen({Key? key,required this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SizedBox(height: MediaQuery.of(context).size.height/5),

        Image.asset(
          'assets/images/wifi.png',
          width: 70,
          height: 70,
          color: accentColor2,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("No Internet Connection"),
        ),
        Material(
          child: InkWell(
            onTap: () {
              retry();
            },
            child: Container(
              width: 100.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(child: Text('Retry', style: TextStyle(fontSize: 18.0, color: Colors.white),),),
            ),
          ),
        ),
      ],
    );
  }
}
