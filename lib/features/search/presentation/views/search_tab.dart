import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/home_tab/presentation/widgets/movie_card.dart';

class SearchTab extends StatefulWidget {
  final List<MovieModel> movies;
  final ValueChanged<String>? onSearchChanged;

  const SearchTab({
    super.key,
    this.movies = const [],
    this.onSearchChanged,
  });

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: widget.onSearchChanged,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.white,
                    size: 24,
                  ),
                  filled: true,
                  fillColor: AppColors.surfaceColor,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Expanded(
                child: widget.movies.isEmpty
                    ? Center(
                  child: Image.asset(
                    AppAssets.popcorn,
                    width: 160,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                )
                    : GridView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: widget.movies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return MovieCard(movie: widget.movies[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}