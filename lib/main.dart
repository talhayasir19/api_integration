import 'package:api_integration/Album.dart';
import 'package:api_integration/Api_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: Provider<ApiAlbumProvider>(
          create: (context) => ApiAlbumProvider(),
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Future<List<Album>> futureAlbumList;

  void _incrementCounter() async {
    bool insertData = await context
        .read<ApiAlbumProvider>()
        .insertData(Album(userId: 1, id: 1, title: "Hello world"));
    if (insertData) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Perfect")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Perfect")));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    futureAlbumList = context.read<ApiAlbumProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<List<Album>>(
              future: futureAlbumList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("Click here to load data");
                } else if (snapshot.connectionState ==
                        ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Album album = snapshot.data![index];
                          return ListTile(
                              leading: CircleAvatar(
                                child: Text(album.id.toString()),
                              ),
                              title: Text(album.title),
                              subtitle: Text(album.userId.toString()));
                        });
                  } else {
                    return const Text("Something went wrong");
                  }
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
