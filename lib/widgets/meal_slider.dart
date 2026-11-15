
import 'package:flutter/material.dart';

class MealSlider extends StatelessWidget {
  final List<Map<String, String?>> meals;

  const MealSlider({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Receptes populars',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (_, int index) {
                return _MealPoster(meal: meals[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MealPoster extends StatelessWidget {
  final Map<String, String?> meal;

  const _MealPoster({required this.meal});

  @override
  Widget build(BuildContext context) {
    final image = meal['strMealThumb'];

    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              'details',
              arguments: meal,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: image != null && image.isNotEmpty
                  ? Image.network(
                      image,
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/no-image.jpg',
                          width: 130,
                          height: 190,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/no-image.jpg',
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            meal['strMeal'] ?? 'Sense nom',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
