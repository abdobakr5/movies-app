import 'package:flutter/material.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'movie_card.dart';

class BannerCarousel extends StatefulWidget {
  final List<MovieModel> movies;
  final ValueChanged<MovieModel>? onMovieChanged;
  final ValueChanged<MovieModel>? onMovieTap;

  const BannerCarousel({
    super.key,
    required this.movies,
    this.onMovieChanged,
    this.onMovieTap,
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _bannerController;
  int _currentBannerPage = 1;

  @override
  void initState() {
    super.initState();

    _bannerController = PageController(
      viewportFraction: 0.58,
      initialPage: _currentBannerPage,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.movies.isNotEmpty) {
        widget.onMovieChanged?.call(
          widget.movies[_currentBannerPage],
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: PageView.builder(
        controller: _bannerController,
        onPageChanged: (int index) {
          setState(() {
            _currentBannerPage = index;
          });

          widget.onMovieChanged?.call(
            widget.movies[index],
          );
        },
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return AnimatedBuilder(
            animation: _bannerController,
            builder: (context, child) {
              double value = 1.0;

              if (_bannerController.position.haveDimensions) {
                value = _bannerController.page! - index;
                value = (1 - (value.abs() * 0.22)).clamp(0.78, 1.0);
              } else {
                value = index == _currentBannerPage ? 1.0 : 0.78;
              }

              return Center(
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 330,
                  width: Curves.easeOut.transform(value) * 220,
                  child: child,
                ),
              );
            },
            child: MovieCard(
              movie: movie,
              borderRadius: 24,
              onTap: () {
                if (widget.onMovieTap != null) {
                  widget.onMovieTap!(movie);
                } else {
                  Navigator.push(
                    context,
                    AppRoutes.movieDetails(movie.id),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
