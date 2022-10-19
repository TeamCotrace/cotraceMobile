
import 'package:cotrace/models/reported.dart';
import 'package:cotrace/services/repository.dart';

class RemoteService {

  Repository? _repository;

  RemoteService() {

    _repository = Repository();

  }

  send_report(Reported data) async {
    return await _repository!.http_postReport(data.toJson());
  }



}