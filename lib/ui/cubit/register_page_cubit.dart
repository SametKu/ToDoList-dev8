import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/data/repo/todothings_dao_repository.dart';

class RegisterPageCubit extends Cubit<void> {
  RegisterPageCubit() : super(0);
  var krepo = toDoDaoRepository();

  Future<void> save(String toDoName) async {
    await krepo.save(toDoName);
  }
}
