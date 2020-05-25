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
              height: 540.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: AssetImage("assets/images/2.png"),
                          ),
                          SizedBox(width:10.0 ,),
                          Text(
                            data[index]["author"].toString(),
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width:170.0 ,),
                          Text(
                            data[index]["topic"].toString(),
                            style: TextStyle(
                              color: Colors.indigo
                            ),
                          ),
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
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(data[index]["upvotes"].toString()),
                          SizedBox(width: 5.0),
                          Text("Upvotes"),
                          SizedBox(width: 10.0),
                          Text(data[index]["comments"].toString()),
                          SizedBox(width: 5.0),
                          Text("Comments"),
                          SizedBox(width: 10.0),
                          Text(data[index]["downvotes"].toString()),
                          SizedBox(width: 5.0),
                          Text("Downvotes"),
                          SizedBox(width: 80.0),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            highlightColor: Colors.blue[100],
                            onPressed: () {}, 
                            icon: Icon(
                              Icons.thumb_up,
                              size: 20.0,
                              color: Colors.blue[200],
                            ), 
                            label: Text("Upvotes"),
                          ),
                          FlatButton.icon(
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            highlightColor: Colors.amber[100],
                            onPressed: () {}, 
                            icon: Icon(
                              Icons.mode_comment,
                              size: 20.0,
                              color: Colors.amber[200],
                            ), 
                            label: Text("Comments"),
                          ),
                          FlatButton.icon(
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            highlightColor: Colors.red[100],
                            onPressed: () {}, 
                            icon: Icon(
                              Icons.thumb_down,
                              size: 20.0,
                              color: Colors.red[200],
                            ), 
                            label: Text("Downvotes"),
                          ),
                        ],
                      ),
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