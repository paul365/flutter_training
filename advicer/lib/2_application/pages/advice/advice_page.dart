import 'package:advicer/2_application/core/services/theme_service.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:advicer/2_application/pages/advice/widgets/error_message.dart';
import 'package:advicer/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerCubit>(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advicer'),
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) =>
                Provider.of<ThemeService>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(child:
                Center(child: BlocBuilder<AdvicerCubit, AdvicerCubitState>(
              builder: (context, state) {
                if (state is AdvicerInitial) {
                  return Text(
                    'Advice is waiting for you',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                } else if (state is AdvicerStateError) {
                  return ErrorMessage(message: state.message);
                } else if (state is AdvicerStateLoading) {
                  return CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  );
                } else if (state is AdvicerStateLoaded) {
                  return AdviceField(advice: state.advice);
                }
                return const SizedBox();
              },
            ))),
            SizedBox(
                height: 200,
                child: Center(
                    child: CustomButton(
                  onTap: () =>
                      BlocProvider.of<AdvicerCubit>(context).adviceRequested,
                ))),
          ],
        ),
      ),
    );
  }
}
