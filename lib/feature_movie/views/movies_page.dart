import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/movies_bloc.dart';

class MoviePage extends StatefulWidget  {
  const MoviePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  @override
  void initState() {
  print('MoviePageInit');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: context.read<MovieBlocType>().events.fetchData,
              ),
            ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             RxBlocListener<MovieBlocType, String>(
              state: (bloc) => bloc.states.errors,
              listener: (context, error) => _onError,
            ),
            Center(
                child: RxResultBuilder<MovieBlocType, String>(
              state: (bloc) => bloc.states.data,
              buildLoading: (ctx, bloc) => const CircularProgressIndicator(),
              buildError: (ctx, error, bloc) => Text(error.toString()),
              buildSuccess: (ctx, state, bloc) => Text(state),
            )),
          ],
        ),
      );}

  void _onError(BuildContext context, String errorMessage) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(errorMessage),
            behavior: SnackBarBehavior.floating,
        ),
      );
}
