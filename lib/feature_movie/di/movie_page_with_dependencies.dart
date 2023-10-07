import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/my_movie_bloc.dart';
import '../views/movie_page.dart';

class MoviePageWithDependencies extends StatelessWidget {
  const MoviePageWithDependencies({
    Key? key,
  }) : super(key: key);

  List<SingleChildWidget> get _blocs => [

        BlocProvider(
          create: (context) => MyMovieBloc(
            movieRepository: context.read(),
          )..add(MyMovieFetchEvent()),
        ),
      ];

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._blocs,
        ],
        child: const MoviePage(),
      );
}
