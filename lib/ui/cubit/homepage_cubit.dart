import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/data/entity/yapilacaklar.dart';
import 'package:todo_list/data/repo/todothings_dao_repository.dart';

class HomePageCubit extends Cubit<List<Yapilacaklar>> {
  HomePageCubit() : super(<Yapilacaklar>[]);

  var krepo = toDoDaoRepository();

  Future<void> uploadToDo() async {
    var list = await krepo.uploadToDo();
    emit(list);
  }

  Future<void> search(String wordOfSearching) async {
    var list = await krepo.search(wordOfSearching);
    emit(list);
  }

  Future<void> delete(int toDoId) async {
    await krepo.delete(toDoId);
    uploadToDo();
  }
}
