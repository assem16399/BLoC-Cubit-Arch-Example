import 'package:bloc_arch_example/features/posts/data/provider/posts_api.dart';
import 'package:bloc_arch_example/features/posts/logic/bloc/posts_bloc.dart';
import 'package:bloc_arch_example/features/posts/logic/cubit/my_posts_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/posts/data/repo/posts_repo.dart';
import '../network/network_info.dart';

final get = GetIt.instance;

Future<void> init() async {
  // TODO register BLoCs
  get.registerFactory(() => PostsBloc(postsRepo: get()));
  get.registerFactory(() => MyPostsCubit(postsRepo: get()));

  //ToDo Register Repos
  get.registerLazySingleton<PostsRepo>(
      () => PostsRepoImpl(postsApi: get(), networkInfo: get()));

  //ToDo Register Repos
  get.registerLazySingleton<PostsApi>(() => PostsApiWithDioImpl());

  //ToDo Register Core

  get.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(get()));

  //ToDo Register External Packages
  get.registerLazySingleton(() => InternetConnectionChecker());
}
