import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/features/home/presentation/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..getMovies(),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is HomeSuccess) {
              final selectedMovie = state.selectedMovie ?? state.movies.first;

              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      selectedMovie.backgroundImageOriginal,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                  PageView.builder(
                    itemCount: state.movies.length,
                    onPageChanged: (index) {
                      context.read<HomeCubit>().selectMovie(
                            state.movies[index],
                          );
                    },
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];

                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              movie.largeCoverImage,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${movie.year} • ⭐ ${movie.rating}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
