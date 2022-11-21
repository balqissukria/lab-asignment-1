import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie extract App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Movie Extract App'),
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
  TextEditingController edit_ = TextEditingController();
  String desc = " ";
  var poster_ = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Simple Movie Extract App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextField(
              controller: edit_,
              decoration: InputDecoration(
                  hintText: 'eg: Superman',
                  suffixIcon: IconButton(
                    onPressed: () => edit_.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(onPressed: getmovie, child: const Text("Search")),
            Text(desc,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Image.network(
              poster_,
              height: 250,
              width: 250,
              errorBuilder: ((context, error, stackTrace) {
                return Image.asset(
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                    'assets/images/movie.png');
              }),
            ),
          ],
        ),
      ),
    );
  }

  getmovie() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();
    var newText = edit_.text;
    var apiid = "ac7dd17c";
    var url = Uri.parse(
        'http://www.omdbapi.com/?t=$newText&apikey=$apiid&units=metric');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        var title = parsedJson['Title'];
        var year = parsedJson['Year'];
        var genre = parsedJson['Genre'];
        var poster = parsedJson['Poster'];
        var plot = parsedJson['Plot'];

        desc =
            '\nMovie name: $title \nRealeased: $year \nGenre: $genre \n\nStoryline: $plot \n ';
        poster_ = '$poster';

        Fluttertoast.showToast(
            msg: "Movie Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.deepPurple,
            timeInSecForIosWeb: 2,
            fontSize: 16.0);
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
    progressDialog.dismiss();
  }
}
