import 'package:bravass_development/src/models/room_model.dart';
import 'package:bravass_development/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class RoomBloc {
  final _repository = new Repository();
  final _roomFetcher = PublishSubject<RoomModel>();

  Observable<RoomModel> get allRoom => _roomFetcher.stream;

  fetchAllRoom() async {
    RoomModel roomModel = await _repository.fetchAllRoom();
    _roomFetcher.sink.add(roomModel);
  }

  dispose() async {
    await _roomFetcher.drain();
    _roomFetcher.close();
  }
}

final roomBloc = RoomBloc();
