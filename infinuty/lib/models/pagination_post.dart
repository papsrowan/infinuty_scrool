import 'package:flutter/material.dart';
import 'package:infinuty/models/post_model.dart';

class PaginationPost {
  final String msg;
  final MetaData meta;
  final List<Post> data;

  PaginationPost({
    required this.data,
    required this.meta,
    required this.msg,
  });

  factory PaginationPost.fromJson(Map<String, dynamic> json) {
    return PaginationPost(
        data: json["data"], meta: json["meta"], msg: json["msg"]);
  }

  Map<String, dynamic> toJson() {
    return {"msg": msg, "meta": meta, "data": data};
  }
}
