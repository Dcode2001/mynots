import 'package:flutter/material.dart';

import 'insertpage.dart';

class gridpage extends StatefulWidget {
  const gridpage({Key? key}) : super(key: key);

  @override
  State<gridpage> createState() => _gridpageState();
}

class _gridpageState extends State<gridpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [/*GridView.builder(
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
    )*/],),);
  }
}
