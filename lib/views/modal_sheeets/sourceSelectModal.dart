import 'package:flutter/material.dart';
import 'package:newsapp/models/sourcsModel.dart';
import 'package:newsapp/themes.dart';

class SourceSelectModal {
  List<Sources> tempSources = [];

  showSourceSelectModal(context,List<Sources> checkedSources,List<Sources?> sources,{required Function(List<Sources>) returnSources}) {

    tempSources.addAll(checkedSources);

    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) =>
          Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.75,
            color: Colors.white,
            child: Column(
              children: [
                new ListTile(
                  title: const Text(
                    'Filter By Sources',
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
                Expanded(
                  child: Container(
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
                        itemCount: sources.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return new Column(
                            children: <Widget>[
                              new   ListTile(
                                trailing: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.all(primaryColor),
                                  value: tempSources.contains(sources[index]),
                                  onChanged: (bool? values) {
                                    if(values!){
                                      tempSources.add(sources[index]!);
                                    }else{
                                      tempSources.remove(sources[index]);

                                    }
                                    setState((){

                                    });
                                  },
                                ),
                                title:  Text(
                                  sources[index]!.name,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () {

                      Navigator.of(context).pop();
                      returnSources(tempSources);
                    },
                    child: new Container(
                      width: 100.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.blueAccent,
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Center(child: new Text('Apply', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        );
      },
    );
  }
}
