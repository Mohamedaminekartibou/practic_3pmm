
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments
        as Map<String, String?>;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(meal: meal),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _MealHeader(meal: meal),
                _MealInfo(meal: meal),
                _Ingredients(meal: meal),
                _Instructions(meal: meal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// APP BAR
class _CustomAppBar extends StatelessWidget {
  final Map<String, String?> meal;

  const _CustomAppBar({required this.meal});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          meal['strMeal'] ?? 'Recepta',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        background: _mealImage(meal['strMealThumb']),
      ),
    );
  }
}

// NOM I FOTOGRAFIA
class _MealHeader extends StatelessWidget {
  final Map<String, String?> meal;

  const _MealHeader({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 120,
              height: 150,
              child: _mealImage(meal['strMealThumb']),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal['strMeal'] ?? 'Sense nom',
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  meal['strCategory'] ?? 'Sense categoria',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  meal['strArea'] ?? 'Origen desconegut',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// INFORMACIO DE LA RECEPTA
class _MealInfo extends StatelessWidget {
  final Map<String, String?> meal;

  const _MealInfo({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          const Icon(Icons.restaurant, color: Colors.indigo),
          const SizedBox(width: 8),
          Text(
            'Categoria: ${meal['strCategory'] ?? 'No disponible'}',
          ),
          const Spacer(),
          const Icon(Icons.public, color: Colors.indigo),
          const SizedBox(width: 5),
          Text(meal['strArea'] ?? 'No disponible'),
        ],
      ),
    );
  }
}

// INGREDIENTS
class _Ingredients extends StatelessWidget {
  final Map<String, String?> meal;

  const _Ingredients({required this.meal});

  @override
  Widget build(BuildContext context) {
    final ingredients = <MapEntry<String, String>>[];

    for (int i = 1; i <= 20; i++) {
      final ingredient = meal['strIngredient$i']?.trim() ?? '';
      final measure = meal['strMeasure$i']?.trim() ?? '';

      if (ingredient.isNotEmpty) {
        ingredients.add(MapEntry(ingredient, measure));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          ...ingredients.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 8,
                    color: Colors.indigo,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item.key)),
                  Text(
                    item.value,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// INSTRUCCIONS
class _Instructions extends StatelessWidget {
  final Map<String, String?> meal;

  const _Instructions({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preparació',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            meal['strInstructions'] ?? 'No hi ha instruccions disponibles.',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// IMATGE AMB CONTROL D'ERROR
Widget _mealImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Image.asset(
      'assets/no-image.jpg',
      fit: BoxFit.cover,
    );
  }

  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Image.asset(
        'assets/no-image.jpg',
        fit: BoxFit.cover,
      );
    },
  );
}
