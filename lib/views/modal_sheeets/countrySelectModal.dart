import 'package:flutter/material.dart';
import 'package:newsapp/themes.dart';

class CountrySelectModal {
  Map<String,String> country = {


    "India" : "in",
    "USA" : "us",
    "Nepal" : "np",
    'Sri Lanka' : 'lk',
    'England' : 'gb'
  };

  showCountrySelectModal(context, String countryCode,{required Function(String,String) countryCodeReturn}) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              new ListTile(
                title: const Text(
                  'Choose your location',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: new Divider(
                  thickness: 2,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  top: 5.0,
                  bottom: 5.0,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: ListView.builder(
                  itemCount: country.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String key = country.keys.elementAt(index);
                    String value = country.values.elementAt(index);
                    return new Column(
                      children: <Widget>[
                        new   ListTile(
                          trailing: Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(primaryColor),
                            value: countryCode == value,
                            shape: CircleBorder(),
                            onChanged: (bool? values) {
                              Navigator.of(context).pop();
                              countryCodeReturn(value,key);
                            },
                          ),
                          title:  Text(
                            '$key',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            countryCodeReturn(value,key);
                          },
                        ),

                      ],
                    );
                  },
                )
              ),
            ],
          ),
        );
      },
    );
  }
}
