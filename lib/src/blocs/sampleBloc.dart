import 'package:coding_challenge_from_kriya/src/models/sampleModels.dart';
import 'package:coding_challenge_from_kriya/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SampleBloc{
  final _repository = Repository();
  final _sampleFetcher = PublishSubject<List<Sample>>();
  Observable<List<Sample>> get allSample => _sampleFetcher.stream;
  fetchAllSample()async{
    List<Sample> sample =await _repository.fetchAllTodo();
    _sampleFetcher.sink.add(sample);
  }
  dispose(){
    _sampleFetcher.close();
  }
}

final bloc = SampleBloc();