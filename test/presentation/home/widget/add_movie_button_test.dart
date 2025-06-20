import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/l10n/app_localizations.dart';
import 'package:uponorflix/presentation/home/bloc/movie_bloc.dart';
import 'package:uponorflix/presentation/home/widget/add_movie_button.dart';

class MockMovieBloc extends Mock implements MovieBloc {}

class FakeMovieEvent extends Fake implements MovieEvent {}

class FakeMovie extends Fake implements Movie {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  setUp(() {});
  Widget createWidget(Widget child, {Locale? locale}) {
    return MaterialApp(
      localizationsDelegates: const [AppLocalizations.delegate],
      locale: locale,
      home: BlocProvider<MovieBloc>.value(value: MockMovieBloc(), child: child),
    );
  }

  testWidgets('AddMovieButton renders FloatingActionButton', (tester) async {
    await tester.pumpWidget(createWidget(const AddMovieButton()));
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('AddMovieButton tooltip', (tester) async {
    await tester.pumpWidget(createWidget(const AddMovieButton()));
    final fab = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );
    expect(fab.tooltip, isNotNull);
  });

  testWidgets('AddMovieButton tooltip shows English when locale is en', (
    tester,
  ) async {
    await tester.pumpWidget(
      createWidget(const AddMovieButton(), locale: const Locale('en')),
    );
    await tester.pumpAndSettle();
    final fab = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );
    expect(fab.tooltip, 'Add movie');
  });

  testWidgets(
    'AddMovieButton tooltip falls back to English for unsupported locale',
    (tester) async {
      await tester.pumpWidget(
        createWidget(const AddMovieButton(), locale: const Locale('fr')),
      );
      await tester.pumpAndSettle();
      final fab = tester.widget<FloatingActionButton>(
        find.byType(FloatingActionButton),
      );
      expect(fab.tooltip, 'Add movie');
    },
  );

  testWidgets('AddMovieButton tooltip shows English when locale is en', (
    tester,
  ) async {
    await tester.pumpWidget(
      createWidget(const AddMovieButton(), locale: const Locale('en')),
    );
    final fab = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );
    expect(fab.tooltip, 'Add movie');
  });
}
