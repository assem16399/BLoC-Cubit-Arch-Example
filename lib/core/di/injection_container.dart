import 'package:get_it/get_it.dart';

import '/features/posts/injection_container.dart' as posts;

final get = GetIt.instance;

void init() {
  posts.init();
}
