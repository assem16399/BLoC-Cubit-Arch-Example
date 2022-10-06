import 'package:internet_connection_checker/internet_connection_checker.dart';

import '/features/posts/data/provider/posts_api.dart';
import '/features/posts/logic/bloc/posts_bloc.dart';
import '../../core/di/injection_container.dart' as main_di_container;
import '../../core/network/network_info.dart';
import '../../features/posts/data/repo/posts_repo.dart';

void init() {
  // TODO register BLoCs
  main_di_container.get
      .registerFactory(() => PostsBloc(postsRepo: main_di_container.get()));

  //  TODO Uncomment to use Cubit as State-Management
  // main_di_container.get
  //     .registerFactory(() => MyPostsCubit(postsRepo: main_di_container.get()));

  //ToDo Register Repos
  main_di_container.get.registerLazySingleton<PostsRepo>(() => PostsRepoImpl(
      postsApi: main_di_container.get(), networkInfo: main_di_container.get()));

  //ToDo Register APIS
  main_di_container.get
      .registerLazySingleton<PostsApi>(() => PostsApiWithDioImpl());

  //ToDo Register Core
  main_di_container.get.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(main_di_container.get()));

  //ToDo Register External Packages
  main_di_container.get
      .registerLazySingleton(() => InternetConnectionChecker());
}
