import 'package:bloc_arch_example/features/posts/logic/cubit/my_posts_cubit.dart';
import 'package:bloc_arch_example/features/posts/presentation/screens/edit_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsOverviewScreen extends StatefulWidget {
  const PostsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<PostsOverviewScreen> createState() => _PostsOverviewScreenState();
}

class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
    BlocProvider.of<MyPostsCubit>(context).getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Architecture Example'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditPostScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<MyPostsCubit, MyPostsState>(
            builder: (context, state) {
              if (state is MyPostsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is MyPostsGettingAllDataFailedState) {
                return Center(
                    child: Text(state.failMsg,
                        style: Theme.of(context).textTheme.headline6));
              }
              final posts = BlocProvider.of<MyPostsCubit>(context).posts;
              return posts.isEmpty
                  ? Center(
                      child: Text(
                        'No Posts To Show',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: posts.length,
                      itemBuilder: (_, index) => Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      posts[index].title,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(posts[index].body),
                                  ],
                                ),
                              ),
                            ),
                          ));
            },
          ),
        ),
      ),
    );
  }
}
