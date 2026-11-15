
import 'package:flutter/material.dart';
import 'package:movies_app/services/meal_service.dart';
import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MealService _mealService = MealService();

  late Future<List<Map<String, String?>>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = _mealService.getMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receptes'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, String?>>>(
        future: _mealsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hi ha receptes disponibles'),
            );
          }

          final meals = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                CardSwiper(meals: meals),
                MealSlider(meals: meals),
              ],
            ),
          );
        },
      ),
    );
  }
}
