import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'talk_post.g.dart';

@JsonSerializable(nullable: false)
class TalkPost {
  final String id;
  final String text;
  final String authorId;
  final String authorName;
  final int date;
  final String avatar;
  final String replyId;
  String replyName;
  String replyText;

  TalkPost({
    @required this.id,
    @required this.text,
    @required this.authorId,
    @required this.authorName,
    @required this.date,
    @required this.avatar,
    @required this.replyId,
  });

  factory TalkPost.fromJson(Map<String, dynamic> json) => _$TalkPostFromJson(json);

  Map<String, dynamic> toJson() => _$TalkPostToJson(this);
}
