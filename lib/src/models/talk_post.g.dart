// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalkPost _$TalkPostFromJson(Map<String, dynamic> json) {
  return TalkPost(
      id: json['id'] as String,
      text: json['text'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      date: json['date'] as int,
      avatar: json['avatar'] as String,
      replyId: json['replyId'] as String)
    ..replyName = json['replyName'] as String
    ..replyText = json['replyText'] as String;
}

Map<String, dynamic> _$TalkPostToJson(TalkPost instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'date': instance.date,
      'avatar': instance.avatar,
      'replyId': instance.replyId,
      'replyName': instance.replyName,
      'replyText': instance.replyText
    };
