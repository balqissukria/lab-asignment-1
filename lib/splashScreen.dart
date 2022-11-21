import 'package:flutter/material.dart';
import 'dart:async';
import 'mainpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        (() => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const MyApp())))));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/movies.png'),
                  fit: BoxFit.cover))),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Movie Extract App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            CircularProgressIndicator(),
            Text("Version 1.0")
          ],
        ),
      )
    ]);
  }
}
