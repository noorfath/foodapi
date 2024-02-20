// To parse this JSON data, do
//
//     final seafood = seafoodFromJson(jsonString);

import 'dart:convert';

Seafood seafoodFromJson(String str) => Seafood.fromJson(json.decode(str));

String seafoodToJson(Seafood data) => json.encode(data.toJson());

class Seafood {
  List<Meal>? meals;

  Seafood({
    this.meals,
  });

  factory Seafood.fromJson(Map<String, dynamic> json) => Seafood(
    meals: json["meals"] == null ? [] : List<Meal>.from(json["meals"]!.map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": meals == null ? [] : List<dynamic>.from(meals!.map((x) => x.toJson())),
  };
}

class Meal {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    strMeal: json["strMeal"],
    strMealThumb: json["strMealThumb"],
    idMeal: json["idMeal"],
  );

  Map<String, dynamic> toJson() => {
    "strMeal": strMeal,
    "strMealThumb": strMealThumb,
    "idMeal": idMeal,
  };
}
