import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/features/browse/presentation/cubit/browse_cubit.dart';
import 'package:movies_app/features/browse/presentation/cubit/browse_state.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/browse_tab/presentation/widgets/browse_movies_grid.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/browse_tab/presentation/widgets/genre_tabs_list.dart';

class BrowseTabBody extends StatelessWidget {
  const BrowseTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BrowseCubit>()..loadBrowseData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<BrowseCubit, BrowseState>(
            builder: (context, state) {
              if (state is BrowseLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.circularProgressIndicator),
                );
              }

              if (state is BrowseErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: AppColors.white),
                  ),
                );
              }

              if (state is BrowseSuccessState) {
                return Column(
                  children: [
                    const SizedBox(height: 12),
                    // شريط الـ Genres الأفقية
                    GenreTabsList(
                      genres: state.genres.toList(),
                      selectedGenre: state.selectedGenre,
                      onGenreSelected: (genre) {
                        context.read<BrowseCubit>().selectGenre(genre);
                      },
                    ),
                    const SizedBox(height: 16),
                    // شبكة الأفلام المفلترة
                    Expanded(
                      child: BrowseMoviesGrid(
                        movies: state.filteredMovies,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
