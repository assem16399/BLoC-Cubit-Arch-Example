import 'package:bloc_arch_example/features/posts/logic/cubit/my_posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/posts/presentation/widgets/default_text_field.dart';
import '../../data/models/post.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  var post = Post(id: DateTime.now().toString(), title: '', body: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DefaultTextField(
                  onSaved: (value) {
                    post = post.copyWith(title: value);
                  },
                  label: 'Title',
                  hintText: 'Title',
                ),
                const SizedBox(height: 20),
                DefaultTextField(
                  maxLines: 8,
                  onSaved: (value) {
                    post = post.copyWith(body: value);
                  },
                  label: 'Body',
                  hintText: 'Body',
                  contentVerticalPadding: 16,
                ),
                const SizedBox(height: 20),
                BlocListener<MyPostsCubit, MyPostsState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is MyPostsOperationSuccessState) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        // BlocProvider.of<PostsBloc>(context)
                        //     .add(AddPostEvent(post));
                        BlocProvider.of<MyPostsCubit>(context).addNewPost(post);
                      },
                      child: Text(
                        'Add New Post',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
