import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
Future<Post> fetchPost() async {
  final response =
  await http.get('https://icanhazdadjoke.com/',headers:{"Accept":"application/json"});

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Check your Internet');
  }
}
class Post {
  String joke;
  Post({this.joke});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      joke: json['joke'],
    );
  }
}

class CardViewModel {
 String joke;
  CardViewModel({
    this.joke
  });
}