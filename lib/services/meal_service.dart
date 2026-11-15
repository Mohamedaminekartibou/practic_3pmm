
import 'package:http/http.dart' as http;
import 'package:movies_app/models/meals.dart';

class MealService {
  static const String _url =
      'https://www.themealdb.com/api/json/v1/1/search.php?f=a';

  Future<List<Map<String, String?>>> getMeals() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final mealResponse = mealResponseFromJson(response.body);

      return mealResponse.meals;
    } else {
      throw Exception('Error al cargar las recetas');
    }
  }

  // Buscar recetas por nombre
  Future<List<Map<String, String?>>> searchMeals(String query) async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$query',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final mealResponse = mealResponseFromJson(response.body);

      return mealResponse.meals;
    } else {
      throw Exception('Error al buscar las recetas');
    }
  }
}
