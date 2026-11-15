
import 'package:flutter/material.dart';
import 'package:movies_app/services/meal_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MealService _mealService = MealService();
  final TextEditingController _controller = TextEditingController();

  Future<List<Map<String, String?>>>? _searchFuture;

  void _searchMeals() {
    final query = _controller.text.trim();

    if (query.isEmpty) return;

    setState(() {
      _searchFuture = _mealService.searchMeals(query);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar recetas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Escribe una receta...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _searchMeals,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onSubmitted: (_) => _searchMeals(),
            ),
          ),

          Expanded(
            child: _searchFuture == null
                ? const Center(
                    child: Text('Busca una receta para comenzar'),
                  )
                : FutureBuilder<List<Map<String, String?>>>(
                    future: _searchFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error al buscar recetas'),
                        );
                      }

                      final meals = snapshot.data ?? [];

                      if (meals.isEmpty) {
                        return const Center(
                          child: Text('No se encontraron recetas'),
                        );
                      }

                      return ListView.builder(
                        itemCount: meals.length,
                        itemBuilder: (context, index) {
                          final meal = meals[index];

                          return ListTile(
                            leading: Image.network(
                              meal['strMealThumb'] ?? '',
                              width: 65,
                              height: 65,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              meal['strMeal'] ?? 'Sin nombre',
                            ),
                            subtitle: Text(
                              meal['strCategory'] ?? 'Sin categoría',
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'details',
                                arguments: meal,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
