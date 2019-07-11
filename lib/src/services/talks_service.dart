import 'dart:async';

import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/services/http_proxy.dart';

class TalksService {
  static const _talksPath = 'talks';

  final HttpProxy _http;

  TalksService(this._http);

  Future<Iterable<TalkPost>> getPosts(String lectureId) => _http.getList<TalkPost>('$_talksPath/$lectureId', (json) => TalkPost.fromJson(json));

  Future<void> createPost(String lectureId, String text, String replyTo) async {
    final params = Map<String, String>();
    params['lectureId'] = lectureId;
    params['text'] = text;
    if (replyTo != null) {
      params['replyTo'] = replyTo;
    }

    return _http.post(_talksPath, params);
  }

  Future<void> deletePost(String postId) => _http.delete('$_talksPath/$postId');
}
