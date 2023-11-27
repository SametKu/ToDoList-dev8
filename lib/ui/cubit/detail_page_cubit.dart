import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/data/repo/todothings_dao_repository.dart';

class DetailPageCubit extends Cubit<void> {
  DetailPageCubit() : super(0);
  var krepo = toDoDaoRepository();

  Future<void> upgrade(int toDoId, String toDoName) async {
    await krepo.upgrade(toDoId, toDoName);
  }
}
