import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future NewsCall(HashSet is_fav1, HashMap is_favdata1) async {
  final url = Uri.parse("https://api.first.org/data/v1/news");
  HashSet is_fav = is_fav1;
  var data = await http.get(url);
  var parse = jsonDecode(data.body);
  List<Widget> list = [];
  // print(parse["data"][0]["title"]);
  for (int i = 0; i < parse["data"].length; i++) {
    var title =
        parse["data"][i].containsKey("title") ? parse["data"][i]["title"] : "";
    var id = parse["data"][i].containsKey("id") ? parse["data"][i]["id"] : 1;
    var summary = parse["data"][i].containsKey("summary")
        ? parse["data"][i]["summary"]
        : "";
    var link =
        parse["data"][i].containsKey("link") ? parse["data"][i]["link"] : "";
    var published = parse["data"][i].containsKey("published")
        ? parse["data"][i]["published"]
        : "";
    list.add(showtile(
      title: title,
      summary: summary,
      id: id,
      published: published,
      link: link,
      is_fav: is_fav,
      is_favdata: is_favdata1,
    ));
  }
  return list;
}

class DisplayNews extends StatelessWidget {
  const DisplayNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HashSet<int> is_fav = HashSet();
    HashMap<int, Widget> is_favdata = HashMap();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: FutureBuilder(
                future: NewsCall(is_fav, is_favdata),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index];
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            size: 35,
                          ),
                          Text(
                            " News",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => show_favs(data: is_favdata,)) );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 35,
                            color: Colors.red,
                          ),
                          Text(
                            "  Favs",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class showtile extends StatefulWidget {
  const showtile(
      {Key key,
      this.id,
      this.title,
      this.summary,
      this.published,
      this.link,
      this.is_fav,
      this.is_favdata})
      : super(key: key);
  final String title, summary, link, published;
  final int id;
  final HashSet is_fav;
  final HashMap is_favdata;
  @override
  _showtileState createState() => _showtileState();
}

class _showtileState extends State<showtile> {
  @override
  Widget build(BuildContext context) {
    var icon = widget.is_fav.contains(widget.id)
        ? Icons.favorite
        : Icons.favorite_border_sharp;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.white,
        dense: true,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              if (widget.is_fav.contains(widget.id)) {
                widget.is_fav.remove(widget.id);
                widget.is_favdata.remove(widget.id);
                icon = Icons.favorite_border_sharp;
              } else {
                widget.is_fav.add(widget.id);
                icon = Icons.favorite;
                widget.is_favdata[widget.id]=widget;
              }
              // if (icon == Icons.favorite)
              //   icon = Icons.favorite_border_sharp;
              // else
              //   icon = Icons.favorite;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                color: Colors.redAccent,
                size: 40,
              ),
            ],
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              widget.summary,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.published,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class show_favs extends StatelessWidget {
  const show_favs({Key key,this.data}) : super(key: key);
  final HashMap data;

  @override
  Widget build(BuildContext context) {
    print(data.keys);
    List<Widget>list= [];
    for(var x in data.values){
      list.add(x);
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: ListView(
                children: list,
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            size: 35,
                          ),
                          Text(
                            " News",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 35,
                            color: Colors.red,
                          ),
                          Text(
                            "  Favs",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
