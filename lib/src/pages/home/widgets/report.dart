import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_flutter/src/bloc/post/post_bloc.dart';
import 'package:hero_flutter/src/models/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(PostFetched()),
      child: Container(
        child: LoadMore(),
        color: Colors.grey[300],
      ),
    );
  }
}

class LoadMore extends StatefulWidget {
  @override
  _LoadMoreState createState() => _LoadMoreState();
}

class _LoadMoreState extends State<LoadMore> {
  final _scrollController = ScrollController();
  late PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<PostBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
              child: Text('failed to fetch posts'),
            );
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('no posts'),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(6),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? BottomLoader()
                    : PostListItem(state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom) _postBloc.add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 1.5),
    );
  }
}

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (new Random().nextInt(3)) {
      case 0:
        icon = FontAwesomeIcons.fileCsv;
        color = Colors.amber;
        break;
      case 1:
        icon = FontAwesomeIcons.fileExcel;
        color = Colors.green;
        break;
      case 2:
        icon = FontAwesomeIcons.filePdf;
        color = Colors.deepOrange;
        break;
      default:
        icon = FontAwesomeIcons.fileWord;
        color = Colors.blueAccent;
    }
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png',
          ),
        ),
        title: SelectableText(post.title),
        subtitle: Text(post.body),
        trailing: FaIcon(
          icon,
          color: color,
        ),
        isThreeLine: true,
        dense: true,
      ),
    );
  }
}