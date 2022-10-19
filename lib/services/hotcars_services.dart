
import 'package:cotrace/models/hotcars.dart';
import 'package:cotrace/services/repository.dart';

class RemoteService {

  Repository? _repository;

  RemoteService() {

    _repository = Repository();

  }

  send_hotcars(Hotcars data) async {
    return await _repository!.http_postHotcars(data.toJson());
  }



}