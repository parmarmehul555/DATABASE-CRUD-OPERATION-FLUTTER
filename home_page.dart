import 'package:crud_evaluation/add_user.dart';
import 'package:crud_evaluation/my_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CRUD Operation",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddUser(null);
                })).then(
                  (value) {
                    setState(() {});
                  },
                );
              },
              child: Icon(
                Icons.add,
                size: 40,
              ))
        ],
      ),
      body: FutureBuilder(
        future: MyDatabase().getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      snapshot.data![index]['name'].toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                    InkWell(
                        onTap: () {
                          MyDatabase()
                              .deleteUser(snapshot.data![index]['id'])
                              .then(
                            (value) {
                              setState(() {});
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          size: 35,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return AddUser(snapshot.data![index]);
                        })).then((value) {
                          setState(() {

                          });
                        },);
                      },
                      child: Icon(Icons.edit),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              '${snapshot.error}',
              style: TextStyle(fontSize: 20),
            ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
