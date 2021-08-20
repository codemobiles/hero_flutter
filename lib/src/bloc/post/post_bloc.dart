import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_flutter/src/models/post.dart';
import 'package:hero_flutter/src/utils/services/network_service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if(event is PostFetched){
      yield โกรธ
    }
  }

  Future<PostState> _mapPostFetchedToState(PostState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await NetworkService().fetchPosts(0);
        return state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        );
      }
      final posts = await NetworkService().fetchPosts(state.posts.length);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: PostStatus.success,
        posts: List.of(state.posts)..addAll(posts),
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }


}
