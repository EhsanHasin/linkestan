import 'package:flutter/material.dart';
import '../utilities/my_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.link),
        title: Text(APP_Name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 7, crossAxisSpacing: 7),
          itemCount: 7,
          itemBuilder: (context, index) {
            return GridTile(
              child: Container(child: Center(child: Text("Item $index")), width: double.infinity, height: double.infinity, color: Colors.green,),
            );
          },
        ),
      ),
    );
  }
}
