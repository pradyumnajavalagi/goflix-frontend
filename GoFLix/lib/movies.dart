import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MovieService{
  final String baseUrl = 'http://10.0.2.2:8000/movies';

  Future<List<dynamic>> getMovies() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      debugPrint(response.body); // Debugging API response
      final decodedData = json.decode(response.body);

      if (decodedData is List) {
        return decodedData; // Return as List directly
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load movies");
    }
  }
  Future <void> addMovie(Map<String, dynamic>movie)async{
    final response = await http.post(Uri.parse(baseUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(movie),
    );
    if(response.statusCode != 201){
      throw Exception("Failed to add movie");
    }
  }
  Future <void> deleteMovie(String id)async{
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if(response.statusCode != 200){
      throw Exception("Failed to delete movie");
    }
  }
  Future <void> updateMovie(String id, Map<String, dynamic>movie)async{
    final response = await http.put(Uri.parse('$baseUrl/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(movie),
    );
    if(response.statusCode != 200){
      throw Exception("Failed to update movie");
    }
  }
}