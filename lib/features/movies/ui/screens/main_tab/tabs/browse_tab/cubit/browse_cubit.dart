import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/domain/usecase/add_to_history_usecase.dart';
import 'package:movies_app/features/movies/domain/usecase/get_browse_movies_usecase.dart';
import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/browse_tab/cubit/browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final GetBrowseMoviesUseCase getBrowseMoviesUseCase;
  final AddToHistoryUseCase addToHistoryUseCase;

  BrowseCubit({
    required this.getBrowseMoviesUseCase,
    required this.addToHistoryUseCase,
  }) : super(BrowseInitialState());

  List<MovieEntity> _allMovies = [];
  Set<String> _genres = {};
  String _selectedGenre = '';

  Future<void> loadBrowseData() async {
    emit(BrowseLoadingState());
    try {
      // 1. جلب قائمة الأفلام من الـ Repository
      _allMovies = await getBrowseMoviesUseCase();

      // 2. عمل Loop وتجميع كافة الـ Genres في Set لإزالة التكرار تلقائياً
      _genres = {};
      for (var movie in _allMovies) {
        _genres.addAll(movie.genres);
      }

      // 3. تحديد التصنيف الأول كافتراضي وتجميع أفلامه
      if (_genres.isNotEmpty) {
        _selectedGenre = _genres.first;
        _filterMoviesBySelectedGenre();
      } else {
        emit(const BrowseSuccessState(
          allMovies: [],
          genres: {},
          selectedGenre: '',
          filteredMovies: [],
        ));
      }
    } catch (e) {
      emit(BrowseErrorState(e.toString()));
    }
  }

  /// تغيير التصنيف المختار وإعادة الفلترة
  void selectGenre(String genre) {
    if (_selectedGenre == genre) return;
    _selectedGenre = genre;
    _filterMoviesBySelectedGenre();
  }

  /// تصفية القائمة بحسب الـ Genre المختار
  void _filterMoviesBySelectedGenre() {
    final filtered = _allMovies.where((movie) {
      return movie.genres.contains(_selectedGenre);
    }).toList();

    emit(BrowseSuccessState(
      allMovies: _allMovies,
      genres: _genres,
      selectedGenre: _selectedGenre,
      filteredMovies: filtered,
    ));
  }

  /// حفظ الفيلم المزار في Firestore History عند ضغط الكرت
  Future<void> addToHistory(MovieEntity movie) async {
    try {
      await addToHistoryUseCase(movie);
    } catch (_) {
      // معالجة الخطأ بشفافية لتجنب تعطيل تجربة المستخدم أثناء التنقل
    }
  }
}
