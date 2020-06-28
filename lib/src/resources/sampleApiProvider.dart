import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:coding_challenge_from_kriya/src/models/sampleModels.dart';

class SampleApiProvider{
  Client client= Client();
  final _baseUrl = "https://jsonplaceholder.typicode.com/todos";
  Future<List<Sample>> fetchTodoList() async{
    print("masuk");
    final response = await client.get(_baseUrl);
    if(response.statusCode == 200){
      return compute(sampleFromJson, response.body);

    }else{
      throw Exception('Failed to Load');
    }
  }
}