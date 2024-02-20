import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapi/model/seafood.dart';
import '../model/categories.dart';
import 'package:http/http.dart' as http;

class meals extends StatefulWidget {


  const meals({Key? key, required this.category}) : super(key: key);

  @override
  State<meals> createState() => _mealsState();
}

class _mealsState extends State<meals> {
  Future<void> getApi() async {
    const String api = "http://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";

    var response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      setState(() {
        seafoodd = Seafood.fromJson(responseData);
      });
    }
  }

  @override
  void initState() {
    getApi();
    super.initState();
  }
  Seafood? seafoodd;
  Category? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category?.strCategory ?? ''),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [


             Image.asset(NetworkImage(category?.strCategoryThumb ?? '') as String);
            Text(category?.strCategory ?? ''),
            SizedBox(height: 20),
            Text(category?.strCategoryDescription ?? ''),
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}
