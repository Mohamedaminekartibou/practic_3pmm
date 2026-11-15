
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  final List<Map<String, String?>> meals;

  const CardSwiper({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: meals.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index) {
          final meal = meals[index];
          final image = meal['strMealThumb'];

          return GestureDetector(
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
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/no-image.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/no-image.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
          );
        },
      ),
    );
  }
}
