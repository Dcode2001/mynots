import 'package:flutter/material.dart';
import 'package:mynots/viewpage.dart';
import 'package:sqflite/sqflite.dart';

import 'DbHelper.dart';

class insertpage extends StatefulWidget {
  @override
  State<insertpage> createState() => _insertpageState();

  int? a;
  Map? m;

  insertpage({required this.a, this.m});
}

class _insertpageState extends State<insertpage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _subject = TextEditingController();

  Database? db;

  @override
  void initState() {
    super.initState();
    DbHelper().createDatabase().then((value) {
      db = value;
    });

    if (widget.a == 1) {
      _title.text = widget.m!['title'];
      _subject.text = widget.m!['subject'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(title: Text("Insert Page"),actions: [IconButton(onPressed: () {

        String title = _title.text;
        String subject = _subject.text;

        if(widget.a==0)
          {
            String qry =
                "INSERT INTO Test (title, subject) VALUES('$title','$subject')";

            db!.rawInsert(qry);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return viewpage();
              },
            ));
          }
        else
          {
            int id = widget.m!['id'];

            String qry =
                "update Test set title='$title',subject='$subject' where id = '$id'";

            db!.rawInsert(qry);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return viewpage();
              },
            ));
          }
      }, icon: Icon(widget.a==0?Icons.done:Icons.done_all))],),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String title = _title.text;
          String subject = _subject.text;

          if(widget.a==0)
            {
              String qry =
                  "INSERT INTO Test (title, subject) VALUES('$title','$subject')";

              db!.rawInsert(qry);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return viewpage();
                },
              ));
            }
          else
            {
              int id = widget.m!['id'];

              String qry =
                  "update Test set title='$title',subject='$subject' where id = '$id'";

              db!.rawInsert(qry);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return viewpage();
                },
              ));
            }

        },
        child: Icon(widget.a==0?Icons.done:Icons.done_all),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              TextField(
                controller: _title,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  // prefixIcon: Icon(Icons.account_box),
                  labelText: "Title",
                  hintText: "Enter Title",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  controller: _subject,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: "Insert your message",),
                  scrollPadding: EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  maxLines: 999999,
                  autofocus: false),
              /*SizedBox(height: 10),
              Center(
                  child: (widget.a == 0)
                      ? ElevatedButton(
                      onPressed: () {
                        String title = _title.text;
                        String subject = _subject.text;

                        String qry =
                            "INSERT INTO Test (title, subject) VALUES('$title','$subject')";

                        db!.rawInsert(qry);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return viewpage();
                          },
                        ));
                      },
                      child: Text("save"))
                      : ElevatedButton(
                      onPressed: () {
                        String title = _title.text;
                        String subject = _subject.text;

                        int id = widget.m!['id'];
                        String qry =
                            "update Test set title='$title',subject='$subject' where id = '$id'";

                        db!.rawUpdate(qry);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return viewpage();
                          },
                        ));
                      },
                      child: Text("Update")))*/
            ],
          ),
        ),
      ),
    ), onWillPop: goback);
  }
  Future<bool> goback()
  {
    String title = _title.text;
    String subject = _subject.text;

    if(widget.a==0)
    {
      String qry =
          "INSERT INTO Test (title, subject) VALUES('$title','$subject')";

      db!.rawInsert(qry);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return viewpage();
        },
      ));
    }
    else
    {
      int id = widget.m!['id'];

      String qry =
          "update Test set title='$title',subject='$subject' where id = '$id'";

      db!.rawInsert(qry);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return viewpage();
        },
      ));
    }
          return Future.value();
  }
 }
