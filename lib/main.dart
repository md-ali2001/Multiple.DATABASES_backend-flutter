import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:postgres/postgres.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = 'aNRmgfCuf4V8uzRCLWLij3UjP9rKuzRh2cdUd549';
  final keyClientKey = 'Ufu17BBaSMCoqPfNHtq2dYEtTXnVFRYcUVWxsSfF';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);



  print('done');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// ...

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => psql(), child: Text("connect to psql")),
            ElevatedButton(
                onPressed: () => mongodbatlas(),
                child: Text("connect to mongodb atlas")),
            ElevatedButton(
                onPressed: () => mongocollection(),
                child: Text("create collection mongodb"))
          ],
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  psql() async {
    var connection = PostgreSQLConnection(" 10.0.2.2", 5432, "postgres",
        username: 'postgres',
        password: "ali",
        useSSL: true,
        isUnixSocket: false);
    //await connection.open()
    await connection.open().then((value) {
      print("Database Connected!");
    });
  }

  mongodbatlas() async {
    var db = await mongo.Db.create(
        "mongodb+srv://ali:ali@cluster0.we3ovhm.mongodb.net/flutter?retryWrites=true&w=majority");
    await db.open();
    var ucollection = db.collection("fluttercollection");
    await ucollection.insertMany([
      {
        'name': 'William Shakespeare',
        'email': 'william@shakespeare.com',
        'age': 587
      },
      {'name': 'Jorge Luis Borges', 'email': 'jorge@borges.com', 'age': 123}
    ]);
  }

  mongocollection() async {
    var db = await mongo.Db.create(
        "mongodb+srv://ali:ali@cluster0.we3ovhm.mongodb.net/flutter?retryWrites=true&w=majority");
    await db.open();
    db.createCollection("new collection");
  }
}
