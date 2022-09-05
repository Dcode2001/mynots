import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'DbHelper.dart';
import 'insertpage.dart';

class listpage extends StatefulWidget {
  const listpage({Key? key}) : super(key: key);

  @override
  State<listpage> createState() => _listpageState();
}

class _listpageState extends State<listpage> {
  Database? db;

  @override
  void initState() {
    super.initState();

    // status = true;
    getAllData();
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Map<String, Object?>> l =
                snapshot.data as List<Map<String, Object?>>;

                return (l.length > 0)
                    ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Map m = l[index];
                    // int id = m['id'];
                    return ListTile(
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
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            );
                          },
                          context: context,
                        );
                      },
                      leading: Text("${m['id']}"),
                      title: Text("${m['title']}"),
                      subtitle: Text("${m['subject']}"),
                    );
                  },
                )
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
