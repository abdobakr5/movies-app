import 'package:flutter/material.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/profile_tab/cubit/profile_state.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/cubit/main_layout_cubit.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/cubit/main_layout_state.dart';
import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/usecase/logout_usecase.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/home_tab/widgets/movie_card.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: const Center(
          child: Text(
            'No history yet',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileCubit cubit = getIt<ProfileCubit>()..fetchUserData();
  final ProfileCubit listsCubit = getIt<ProfileCubit>()
    ..getWishlistAndHistory();

  @override
  void dispose() {
    cubit.close();
    listsCubit.close();
    super.dispose();
  }

  int selectedTab = 0; // 0 = Watch List, 1 = History
  @override
  Widget build(BuildContext context) {
    return BlocListener<MainLayoutCubit, MainLayoutState>(
      listener: (context, state) {
        if (state.currentIndex == 3) listsCubit.getWishlistAndHistory();
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.black,
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                // 1. Header
                SliverToBoxAdapter(child: buildHeader()),

                // 2. Tabs (pinned: true = they stick to the top)
                SliverAppBar(
                  pinned: true,
                  primary: false,
                  toolbarHeight: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.grey,
                  surfaceTintColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  bottom: buildTabBar(),
                ),

                // 3. Content of the selected tab
                BlocBuilder<ProfileCubit, ProfileState>(
                  bloc: listsCubit,
                  buildWhen: (_, state) =>
                      state is ProfileWishlistAndHistoryLoaded,
                  builder: (context, state) {
                    final movies = state is ProfileWishlistAndHistoryLoaded
                        ? (selectedTab == 0 ? state.wishlist : state.history)
                        : <MovieEntity>[];
                    if (movies.isEmpty) {
                      return selectedTab == 0
                          ? buildEmptyWatchList()
                          : const HistoryTab();
                    }
                    return buildMoviesGrid(movies);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- Header ----------------

  Widget buildHeader() {
    return Container(
      color: AppColors.grey,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar + name
              BlocBuilder<ProfileCubit, ProfileState>(
                bloc: cubit,
                builder: (context, state) {
                  final user = state is ProfileSuccess ? state.user : null;
                  return SizedBox(
                    width: 118,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 59,
                          backgroundColor: Colors.transparent,
                          backgroundImage: user == null
                              ? null
                              : AssetImage(
                                  AppAssets.allAvatars[user.avatarIndex]),
                        ),
                        const SizedBox(height: 12),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            user?.name ?? '',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  bloc: listsCubit,
                  buildWhen: (_, state) =>
                      state is ProfileWishlistAndHistoryLoaded,
                  builder: (context, state) {
                    final count = state is ProfileWishlistAndHistoryLoaded
                        ? state.wishlist.length
                        : 0;
                    return buildStatItem('$count', 'Wish List');
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  bloc: listsCubit,
                  buildWhen: (_, state) =>
                      state is ProfileWishlistAndHistoryLoaded,
                  builder: (context, state) {
                    final count = state is ProfileWishlistAndHistoryLoaded
                        ? state.history.length
                        : 0;
                    return buildStatItem('$count', 'History');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: buildButton(
                  text: 'Edit Profile',
                  color: AppColors.yellow,
                  textColor: AppColors.black,
                  onPressed: () async {
                    await Navigator.push(context, AppRoutes.updateProfile());
                    cubit.fetchUserData();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildButton(
                  text: 'Exit',
                  color: AppColors.red,
                  textColor: Colors.white,
                  icon: Icons.logout_rounded,
                  onPressed: logout,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    await getIt<LogoutUsecase>()();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(AppRoutes.login(), (_) => false);
  }

  Widget buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // FittedBox makes the text smaller on small phones instead of overflowing
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: const TextStyle(fontSize: 20)),
            if (icon != null) const SizedBox(width: 8),
            if (icon != null) Icon(icon),
          ],
        ),
      ),
    );
  }

  // ---------------- Tabs ----------------

  TabBar buildTabBar() {
    return TabBar(
      onTap: (index) {
        setState(() {
          selectedTab = index;
        });
      },
      indicatorColor: AppColors.yellow,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelColor: AppColors.white,
      unselectedLabelColor: AppColors.white,
      labelStyle: const TextStyle(fontSize: 20),
      tabs: const [
        Tab(
          icon: Icon(
            Icons.format_list_bulleted_rounded,
            color: AppColors.yellow,
            size: 30,
          ),
          text: 'Watch List',
        ),
        Tab(
          icon: Icon(Icons.folder_rounded, color: AppColors.yellow, size: 30),
          text: 'History',
        ),
      ],
    );
  }

  Widget buildMoviesGrid(List<MovieEntity> movies) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      sliver: SliverGrid.builder(
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) => MovieCard(
          movie: movies[index],
          onTap: () async {
            await Navigator.push(
                context, AppRoutes.movieDetails(movies[index].id));
            listsCubit.getWishlistAndHistory();
          },
        ),
      ),
    );
  }

  Widget buildEmptyWatchList() {
    // SliverFillRemaining = take the rest of the screen under the tabs
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Center(
            child:
                Image.asset('assets/profile_images/Empty 1.png', width: 124)),
      ),
    );
  }
}
