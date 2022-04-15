import 'package:flutter/material.dart';
import 'search_places_screen.dart';


class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}


class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Form"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [



            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const SearchPlacesScreen();
              }));
            }, child: const Text("Choose place that you visit"))
          ],
        ),
      ),
    );
  }
}