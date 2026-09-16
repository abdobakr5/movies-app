import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../../../../core/services/services_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..getMovies(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
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
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];

                  return ListTile(
                    leading: Image.network(
                      movie.mediumCoverImage,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(movie.title),
                    subtitle: Text(
                      '${movie.year} • ⭐ ${movie.rating}',
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}