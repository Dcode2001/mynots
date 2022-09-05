import 'package:flutter/material.dart';
import 'package:mynots/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'DbHelper.dart';
import 'insertpage.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  // List<Map<String, Object?>> l = List.empty(growable: true);
  // TextEditingController _title = TextEditingController();
  // TextEditingController _subject = TextEditingController();

  Database? db;
  bool status = false;

  @override
  void initState() {
    super.initState();

    // status = true;
    getAllData();
    storepref();
  }

  storepref() async {
    Utils.prefs = await SharedPreferences.getInstance();
    status = Utils.prefs!.getBool('status') ?? true;
  }

  getAllData() async {
    db = await DbHelper().createDatabase();

    String qry = "select * from Test";

    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);
    // l.addAll(l1);
    return l1;
    // setState(() {
    //   print(l);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Page"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Choose Your Category"),
                        content: Text("Choose Listview Or Gridview"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              //   return listpage();
                              // },));
                              await Utils.prefs!.setBool('status', true);
                              setState(() {
                                status = true;
                              });
                            },
                            child: Text(
                              "ListView",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                //   return viewpage();
                                // },));
                                await Utils.prefs!.setBool('status', false);
                                setState(() {
                                  status = false;
                                });
                              },
                              child: Text("GridView",
                                  style: TextStyle(fontSize: 20)))
                        ],
                      );
                    },
                    context: context);
              },
              icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return insertpage(a: 0);
            },
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // print("body= $status");
                status = Utils.prefs!.getBool('status') ?? true;
                List<Map<String, Object?>> l =
                    snapshot.data as List<Map<String, Object?>>;

                return (l.length > 0)
                    ? (status
                        ? ListView.builder(
                            itemCount: l.length,
                            itemBuilder: (context, index) {
                              Map m = l[index];
                              // int id = m['id'];
                              return Container(
                                margin: EdgeInsets.all(3.5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return insertpage(
                                          a: 1,
                                          m: m,
                                        );
                                      },
                                    ));
                                  },
                                  onLongPress: () {
                                    showDialog(
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Delete"),
                                          content: Text(
                                              "Are You Sure ${m['title']} is Permanatly Delete??"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancle")),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  int id = m['id'];

                                                  String qry =
                                                      "DELETE FROM Test WHERE id = '$id'";

                                                  await db!.rawDelete(qry);
                                                  setState(() {});

                                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                                  //   return insertpage();
                                                  // },));
                                                },
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        );
                                      },
                                      context: context,
                                    );
                                  },
                                  // leading: Text("${m['id']}"),
                                  title: Text(
                                    "${m['title']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold,fontSize: 19),
                                  ),
                                  subtitle: Text("${m['subject']}",style: TextStyle(fontSize: 17),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            itemCount: l.length,
                            itemBuilder: (context, index) {
                              Map m = l[index];
                              // int id = m['id'];
                              return Container(
                                margin: EdgeInsets.all(3.5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return insertpage(
                                            a: 1,
                                            m: m,
                                          );
                                        },
                                      ));
                                    },
                                    onLongPress: () {
                                      showDialog(
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Delete"),
                                            content: Text(
                                                "Are You Sure ${m['title']} is Permanatly Delete??"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancle")),
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    int id = m['id'];

                                                    String qry =
                                                        "DELETE FROM Test WHERE id = '$id'";

                                                    await db!.rawDelete(qry);
                                                    setState(() {});

                                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                                    //   return insertpage();
                                                    // },));
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          );
                                        },
                                        context: context,
                                      );
                                    },
                                    // leading: Text("${m['id']}"),
                                    title: Text("${m['title']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19)),
                                    subtitle: Text("${m['subject']}",
                                        style: TextStyle(fontSize: 17),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3)),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1),
                          ))
                    : Center(child: Text("No Data Found"));
              }
            }
            return Center(child: CircularProgressIndicator());
          },
          future: getAllData(),
        ),
      ),
    );
  }
}
