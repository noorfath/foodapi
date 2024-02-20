import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapi/view/meals.dart';
import '../model/categories.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getApi() async {
    const String api = "http://www.themealdb.com/api/json/v1/1/categories.php";

    var response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      setState(() {
        categoriess = Categories.fromJson(responseData);
      });
    }
  }

  @override
  void initState() {
    getApi();
    super.initState();
  }

  Categories? categoriess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: categoriess == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: categoriess!.categories!.length,
        itemBuilder: (context, index) {
          var category = categoriess!.categories![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,MaterialPageRoute(builder: (context)=>meals(category: category))
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(category.strCategoryThumb ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category.strCategory ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          category.strCategoryDescription ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
