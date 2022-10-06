import 'package:bloc_arch_example/core/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/di/injection_container.dart' as di;
import '/core/network/remote/dio_helper.dart';
import '/features/posts/logic/bloc/posts_bloc.dart';
import '/features/posts/presentation/screens/posts_overview_screen.dart';
import 'core/components/constants/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  di.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsBloc>(
      create: (context) => di.get<PostsBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        home: const PostsOverviewScreen(),
      ),
    );
  }
}
