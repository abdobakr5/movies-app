import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import '../../data/models/movie_model.dart';
import '../widgets/action_movies_list.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/section_header.dart';

class HomeTabBody extends StatefulWidget {
  final List<MovieModel> bannerMovies;
  final List<MovieModel> actionMovies;

  const HomeTabBody({
    super.key,
    this.bannerMovies = const [],
    this.actionMovies = const [],
  });

  @override
  State<HomeTabBody> createState() => _HomeTabBodyState();
}

class _HomeTabBodyState extends State<HomeTabBody> {
  int _selectedBannerIndex = 1;

  @override
  Widget build(BuildContext context) {
    final banners = widget.bannerMovies.isNotEmpty
        ? widget.bannerMovies
        : MovieModel.dummyBannerMovies;

    final actions = widget.actionMovies.isNotEmpty
        ? widget.actionMovies
        : MovieModel.dummyActionMovies;

    final activeMovie =
        banners[_selectedBannerIndex.clamp(0, banners.length - 1)];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121318),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. Banner Area With Asset Background Image & Gradient Blend
              Stack(
                children: [
                  // Asset Background Image
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(
                              'assets/home_tab_images/home_background-2.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.55),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Gradient Overlay blend into screen background
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

                  // Content Layer
                  Column(
                    children: [
                      const SizedBox(height: 10),

                      // "Available Now" Styled Header
                      _buildHeaderGraphic(
                        assetPath: AppAssets.availableNow,
                        height: 55,
                      ),

                      const SizedBox(height: 12),

                      // Carousel
                      BannerCarousel(
                        movies: banners,
                      ),

                      const SizedBox(height: 16),

                      // "Watch Now" Styled Header
                      _buildHeaderGraphic(
                        assetPath: AppAssets.watchNow,
                        height: 65,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 3. Category Header: Action
              SectionHeader(
                title: 'Action',
                onSeeMoreTap: () {},
              ),

              const SizedBox(height: 12),

              // 4. Action Movies List
              ActionMoviesList(movies: actions),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت لعرض صورة النص "Available Now / Watch Now" المطابقة لـ text.png
  Widget _buildHeaderGraphic({
    required String assetPath,
    //required String fallbackText,
    required double height,
  }) {
    return Center(
      child: Image.asset(
        assetPath,
        height: height,
        fit: BoxFit.contain,
        // errorBuilder: (context, error, stackTrace) {
        //   return Image.asset(
        //     AppAssets.availableNow,
        //     height: height,
        //   );
        // },
      ),
    );
  }
}
