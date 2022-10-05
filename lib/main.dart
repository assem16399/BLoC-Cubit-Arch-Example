import 'package:bloc_arch_example/core/network/remote/dio_helper.dart';
import 'package:bloc_arch_example/features/posts/logic/cubit/my_posts_cubit.dart';
import 'package:bloc_arch_example/features/posts/presentation/screens/posts_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/di/injection_container.dart' as di;
import 'core/constants/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await di.init();

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
    return BlocProvider<MyPostsCubit>(
      create: (context) => di.get<MyPostsCubit>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostsOverviewScreen(),
      ),
    );
  }
}
