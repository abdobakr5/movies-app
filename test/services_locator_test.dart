import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/features/movie_details/ui/cubit/movie_details_cubit.dart';

void main() {
  setUpAll(servicesLocator);

  test('MovieDetailsCubit is registered in getIt', () {
    expect(getIt.isRegistered<MovieDetailsCubit>(), isTrue);
  });
}
