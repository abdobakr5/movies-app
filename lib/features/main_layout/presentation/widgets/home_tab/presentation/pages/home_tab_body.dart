import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/app_assets.dart';
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
          if (state is HomeSuccess) {
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
            if (uiMovies.isNotEmpty && selectedMovie == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && selectedMovie == null) {
                  _prepareBackground(context, uiMovies.first);
                }
              });
            }
            return _buildHomeContent(uiMovies);
          }
          return const Scaffold(
            backgroundColor: Color(0xFF121318),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHomeContent(List<ui_model.MovieModel> movies) {
    if (selectedMovie == null || !isBackgroundReady) {
      return const Scaffold(
        backgroundColor: Color(0xFF121318),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final banners =
        movies.isNotEmpty ? movies : ui_model.MovieModel.dummyBannerMovies;
    final actions = movies.isNotEmpty
        ? movies.take(10).toList()
        : ui_model.MovieModel.dummyActionMovies;
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
                    child: Image.network(
                      selectedMovie!.backgroundUrl,
                      fit: BoxFit.cover,
                    ),
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
                          setState(() {
                            selectedMovie = movie;
                          });
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
              ActionMoviesList(movies: actions),
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
