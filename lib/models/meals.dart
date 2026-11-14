// To parse this JSON data, do
//
//     final mealResponse = mealResponseFromJson(jsonString);

import 'dart:convert';

MealResponse mealResponseFromJson(String str) => MealResponse.fromJson(json.decode(str));

String mealResponseToJson(MealResponse data) => json.encode(data.toJson());

class MealResponse {
    final List<Map<String, String?>> meals;

    MealResponse({
        required this.meals,
    });

    factory MealResponse.fromJson(Map<String, dynamic> json) => MealResponse(
        meals: List<Map<String, String?>>.from(json["meals"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    );

    Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    };
}
