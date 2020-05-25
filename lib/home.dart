import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:nosql/splash.dart';

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ProxyNotes",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List data;

  void getinfo() async{
    Response response = await get("http://revidly.surge.sh/revidlyapi.json");
    //List data = jsonDecode(response.body);
    this.setState(() { 
      data = jsonDecode(response.body);
    });
  
  }

  @override
  void initState() {
    super.initState();
    this.getinfo();
  }


  @override
  Widget build(BuildContext context) {
    if(data==null){
      return Splash();
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text("Flutter iOS developer internship task"),
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 550.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: AssetImage("assets/images/2.png"),
                          ),
                          SizedBox(width:15.0 ,),
                          Text(data[index]["author"].toString()),
                          SizedBox(width:145.0 ,),
                          Text(data[index]["topic"].toString()),
                        ],
                      ),                                                //As the online image is not safe so we cant load from online, thus we had to use offline mode.
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(data[index]["description"].toString())
                        ),
                      ),
                      Image.asset("assets/images/1.png"),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Comments"),
                            Text("Upvotes"),
                            Text("Downvotes"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 38.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(data[index]["comments"].toString()),
                            Text(data[index]["upvotes"].toString()),
                            Text(data[index]["downvotes"].toString()),
                          ],
                        ),
                      )
                    ],
                  )
                ),
              ),
            );
          },
        ),
      );
    }
  }
}