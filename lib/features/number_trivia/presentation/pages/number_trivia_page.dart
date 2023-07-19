import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import '../../../../injection_container.dart';

import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    final numberTriviaBloc = sl<NumberTriviaBloc>();
    return BlocProvider(
      create: (_) => numberTriviaBloc,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Top half
            _buildNumberDisplay(context),
            const SizedBox(height: 20),
            // Bottom half
            const TriviaControls(),
          ],
        ),
      )),
    );
  }

  _buildNumberDisplay(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is NumberTriviaEmpty) {
          return const MessageDisplay(message: 'Start searching');
        } else if (state is NumberTriviaLoading) {
          return LoadingWidget();
        } else if (state is NumberTriviaLoaded) {
          return TriviaDisplay(numberTrivia: state.trivia);
        } else if (state is NumberTriviaError) {
          return MessageDisplay(message: state.message);
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: const Placeholder(),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Number Trivia'),
    );
  }
}
