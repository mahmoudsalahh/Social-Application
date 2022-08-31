
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search'),
      ),
      body:  SingleChildScrollView(
    child: Column(
    children: [
    Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/hhhh.jpg'), fit: BoxFit.cover),)
    ),
    ])
      ),
    );
  }
}