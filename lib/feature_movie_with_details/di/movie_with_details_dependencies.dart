import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/movie_with_details_bloc.dart';
import '../views/movie_with_details_page.dart';


class MovieWithDetailsPageWithDependencies extends StatelessWidget {
  const MovieWithDetailsPageWithDependencies({
    Key? key,
  }) : super(key: key);

  List<RxBlocProvider> get _blocs => [
    RxBlocProvider<MovieWithDetailsBlocType>(
      create: (context) => MovieWithDetailsBloc (
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ..._blocs,
    ],
    child: const MovieWithDetailsPage(),
  );
}
