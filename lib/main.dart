import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_integration/CommentsModel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CommentsModel> list = [];

  Future<List<CommentsModel>> getData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    List<dynamic> data = jsonDecode(response.body.toString());
    print((CommentsModel.fromJson(data[3]).id));
    for (Map<String, dynamic> i in data) {
      list.add(CommentsModel.fromJson(i));
      //   print(i);
    }
    // print(data.runtimeType);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: getData(),
                  builder: ((context, snapshot) {
                    return Center(child: Text("Hello"));
                  }),
                ),
                ElevatedButton(
                    onPressed: (() {
                      getData();
                    }),
                    child: Text("Press here"))
              ],
            )));
  }
}
