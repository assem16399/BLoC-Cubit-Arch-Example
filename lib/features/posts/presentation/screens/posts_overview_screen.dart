import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/posts/presentation/screens/edit_post_screen.dart';
import '../../logic/bloc/posts_bloc.dart';
import '../widgets/post_list_item.dart';

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
    BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
    //BlocProvider.of<MyPostsCubit>(context).getAllPosts();
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
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is PostsGettingAllDataFailedState) {
                return Center(
                    child: Text(state.failMsg,
                        style: Theme.of(context).textTheme.headline6));
              }
              final posts = BlocProvider.of<PostsBloc>(context).posts;
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
                      itemBuilder: (_, index) => PostListItem(
                            title: posts[index].title,
                            body: posts[index].body,
                          ));
            },
          ),
        ),
      ),
    );
  }
}
