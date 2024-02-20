import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapi/model/seafood.dart';
import '../model/categories.dart';
import 'package:http/http.dart' as http;

class Meals extends StatefulWidget {
  final Category category;

  const Meals({Key? key, required this.category}) : super(key: key);

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  late Future<void> _apiFuture;
  late Seafood _seafood;

  @override
  void initState() {
    super.initState();
    _apiFuture = getApi();
  }

  Future<void> getApi() async {
    const String api = "http://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";

    var response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      setState(() {
        _seafood = Seafood.fromJson(responseData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.strCategory ?? ''),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _apiFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.category.strCategory ?? ''),
                  SizedBox(height: 20),
                  Text(widget.category.strCategoryDescription ?? ''),
                  _buildMealsList(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMealsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _seafood.meals?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_seafood.meals?[index].strMeal ?? ''),
          leading: Image.network(_seafood.meals?[index].strMealThumb ?? ''),
          // You can add more details as needed
        );
      },
    );
  }
}
