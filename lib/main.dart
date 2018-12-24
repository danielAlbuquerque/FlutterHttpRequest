import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {

  List _data = await getJson();

  print(_data);

  void _showOnTapMessage(BuildContext context, String message) {
    var alert = new AlertDialog(
      title: Text("My app"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON parse'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),

      body: new Center(
        child: new ListView.builder(
          itemCount: _data.length,
          padding: const EdgeInsets.all(14.5),
          itemBuilder: (BuildContext context, int position){
            return Column(
              children: <Widget>[
                new Divider(height: 5.5),
                new ListTile(
                  title: Text("${_data[position]['title']}",
                  style: new TextStyle(
                    fontSize: 17.9
                  ),),
                  subtitle: Text("${_data[position]['body']}",
                  style: new TextStyle(
                    fontSize: 13.9,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic
                  )),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Text("${_data[position]['body'][0]}",
                    style: new TextStyle(fontSize: 13.4, color: Colors.orangeAccent))
                  ),
                  onTap: () => _showOnTapMessage(context, _data[position]['body']),
                )
              ],
            );
          }),
        )
      )
    ),
  );
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}