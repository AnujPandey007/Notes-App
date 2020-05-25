import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:nosql/Loading.dart';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List data;

  final String dbName = "socialPost";

  //Fetching The Data 

  void getinfo() async {
    await Hive.openBox(dbName);
    final posts = Hive.box(dbName);
    //Checking if data exists in database
    if(posts.length == 0) {
      Response response = await get("http://revidly.surge.sh/revidlyapi.json"); //Api Link
      this.setState(() {
        data = jsonDecode(response.body);
        addSocialPost(data);
      });
    } else {
      this.setState(() {
        //Remove previous data if 'data' variable is not null
        if(data != null)
          data.clear();
        else
          data = new List<dynamic>();
          //Converting Map to List of "posts"
          posts.toMap().entries.forEach((element) {
          data.add(element.value);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getinfo();
  }

  void addSocialPost(final data){
    Hive.box(dbName).addAll(data); //Add data to database
  }

  @override
  void dispose() {
    Hive.box(dbName).close(); //Closing database
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(data==null){
      return Loading();  //If Data Is Null Showing Loading Screen
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