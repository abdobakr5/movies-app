import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart'
as home_model;
import 'package:movies_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/home_tab/data/models/movie_model.dart'
as ui_model;
import 'package:movies_app/features/main_layout/presentation/widgets/home_tab/presentation/widgets/action_movies_list.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/home_tab/presentation/widgets/banner_carousel.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/home_tab/presentation/widgets/section_header.dart';

class HomeTabBody extends StatefulWidget {
  const HomeTabBody({super.key});

  @override
  State<HomeTabBody> createState() => _HomeTabBodyState();
}

class _HomeTabBodyState extends State<HomeTabBody> {
  ui_model.MovieModel? selectedMovie;
  bool isBackgroundReady = false;

  Future<void> _prepareBackground(
      BuildContext context,
      ui_model.MovieModel movie,
      ) async {
    try {
      await precacheImage(
        NetworkImage(movie.backgroundUrl),
        context,
      );

      if (!mounted) return;

      setState(() {
        selectedMovie = movie;
        isBackgroundReady = true;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        selectedMovie = movie;
        isBackgroundReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..getMovies(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is! HomeSuccess) {
            return const SizedBox.shrink();
          }

          final uiMovies = state.movies.map((movie) {
            return ui_model.MovieModel(
              id: movie.id.toString(),
              imageUrl: movie.largeCoverImage,
              rating: movie.rating.toStringAsFixed(1),
              title: movie.title,
              backgroundUrl: movie.largeCoverImage,
              genres: movie.genres,
            );
          }).toList();

          final homeMovies = state.movies.map((movie) {
            return home_model.MovieModel(
              id: movie.id,
              titleEnglish: movie.titleEnglish,
              titleLong: movie.titleLong,
              title: movie.title,
              year: movie.year,
              runtime: movie.runtime,
              rating: movie.rating,
              summary: movie.summary,
              descriptionFull: movie.descriptionFull,
              genres: movie.genres,
              backgroundImage: movie.backgroundImage,
              backgroundImageOriginal: movie.backgroundImageOriginal,
              smallCoverImage: movie.smallCoverImage,
              mediumCoverImage: movie.mediumCoverImage,
              largeCoverImage: movie.largeCoverImage,
            );
          }).toList();

          if (uiMovies.isNotEmpty && selectedMovie == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && selectedMovie == null) {
                _prepareBackground(context, uiMovies.first);
              }
            });
          }

          return _buildHomeContent(uiMovies, homeMovies);
        },
      ),
    );
  }

  Widget _buildHomeContent(
      List<ui_model.MovieModel> movies,
      List<home_model.MovieModel> homeMovies,
      ) {
    if (movies.isNotEmpty && !isBackgroundReady) {
      return const Scaffold(
        backgroundColor: Color(0xFF121318),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final List<home_model.MovieModel> banners = homeMovies;

    final List<home_model.MovieModel> actions =
    homeMovies.take(10).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121318),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: selectedMovie != null
                        ? Image.network(
                      selectedMovie!.backgroundUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return const SizedBox.expand();
                      },
                    )
                        : const SizedBox.expand(),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.55),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xBB121318),
                            Colors.transparent,
                            Color(0xFF121318),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildHeaderGraphic(
                        assetPath: AppAssets.availableNow,
                        height: 55,
                      ),
                      const SizedBox(height: 12),
                      BannerCarousel(
                        movies: banners,
                        onMovieChanged: (movie) {
                          final selected = movies.where(
                                (uiMovie) =>
                            uiMovie.id == movie.id.toString(),
                          );

                          if (selected.isNotEmpty) {
                            setState(() {
                              selectedMovie = selected.first;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildHeaderGraphic(
                        assetPath: AppAssets.watchNow,
                        height: 65,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SectionHeader(
                title: 'Action',
                onSeeMoreTap: () {},
              ),
              const SizedBox(height: 12),
              ActionMoviesList(
                movies: actions,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderGraphic({
    required String assetPath,
    required double height,
  }) {
    return Center(
      child: Image.asset(
        assetPath,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}