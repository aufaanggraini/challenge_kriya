import 'package:coding_challenge_from_kriya/src/models/sampleModels.dart';
import 'package:coding_challenge_from_kriya/src/resources/sampleApiProvider.dart';

class Repository{
  final sampleApiProvider = SampleApiProvider();

  Future<List<Sample>> fetchAllTodo() => sampleApiProvider.fetchTodoList();
  
   
}