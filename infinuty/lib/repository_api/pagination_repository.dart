import 'dart:convert';

import 'package:infinuty/models/post_model.dart';
import 'package:http/http.dart' as http;

class PaginationRepository {
  String apiUrl = "http://192.168.109.241:3333/api/v1";

  PaginationRepository();

  Future<List<Post>> getPostPerPage(int page) async{
    try {
      final response = await http.get(Uri.parse("$apiUrl/posts?page=$page"), headers: <String,String>  {
        "Content-Type":"application/json; charset=UTF-8",
        "*":"*"
      });
      if (response.statusCode==200) {
        print("receive dat");
       Map<String,dynamic> jsonData = json.decode(response.body);
       List<dynamic> data = jsonData["data"];

       List<Post> posts = data.map((e)=> Post.fromJson(e)).toList();

       return posts;
      }else{
        throw Exception("Erreur lors de la recuperation");
      }
    } on Exception catch (e) {
      throw Exception("Erreur lors de la recuperation des posts:$e");
    }
  }
}
