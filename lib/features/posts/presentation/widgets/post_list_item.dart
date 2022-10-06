import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}
