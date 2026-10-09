import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 12 placeholder posters until we get the real ones from the API
    List<String> posters = List.generate(
      12,
          (index) => 'https://picsum.photos/seed/movie$index/300/450',
    );

    double navBarHeight = MediaQuery.of(context).padding.bottom;

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, navBarHeight + 16),
      sliver: SliverGrid.builder(
        itemCount: posters.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.68, // poster shape (width / height)
        ),
        itemBuilder: (context, index) {
          return buildMovieCard(posters[index], '7.7');
        },
      ),
    );
  }

  Widget buildMovieCard(String posterUrl, String rating) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: AppColors.darkGrey, // shows while the poster is loading
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.movie_outlined, color: AppColors.grey);
              },
            ),

            // Rating in the top left corner
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.op70black, // black with 70% opacity
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating,
                      style: const TextStyle(color: AppColors.white, fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
