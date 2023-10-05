import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/movies_bloc.dart';
import '../views/movies_page.dart';

class MoviePageWithDependencies extends StatelessWidget  {
  const MoviePageWithDependencies({
    Key? key,
  }) : super(key: key);

  List<RxBlocProvider> get _blocs => [
    RxBlocProvider<MovieBlocType>(
      create: (context) => MovieBloc(),
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
