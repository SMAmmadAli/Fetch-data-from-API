import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}
class _ApiState extends State<Api> {

  getUser()async{
    var users = [];
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com','users'));
    var jsondata = jsonDecode(response.body);

    for(var i in jsondata){
      UserModel user = UserModel(i['id'],i['name'],i['address']['city']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
            future: getUser(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Text("No Data in API"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(snapshot.data[i].name),
                        subtitle: Text(snapshot.data[i].company),
                      );
                    });
              }
            })
    );
  }
}

class UserModel{
  final String aid;
  final String name;
  final String aemail;

  UserModel(this.aid, this.name, this.aemail);
}