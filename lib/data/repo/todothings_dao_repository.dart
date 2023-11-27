import 'package:todo_list/data/entity/yapilacaklar.dart';
import 'package:todo_list/sqlite/veritabani_yardimcisi.dart';

class toDoDaoRepository {
  Future<void> save(String toDoName) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var newthing = <String, dynamic>{};
    newthing["to_do_name"] = toDoName;

    await db.insert("Yapilacaklar", newthing);
  }

  Future<void> upgrade(int toDoId, String toDoName) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var upgratedthing = <String, dynamic>{};
    upgratedthing["to_do_name"] = toDoName;

    await db.update("Yapilacaklar", upgratedthing,
        where: "to_do_id=?", whereArgs: [toDoId]);
  }

  Future<List<Yapilacaklar>> uploadToDo() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> rows =
        await db.rawQuery("SELECT * FROM Yapilacaklar");

    return List.generate(rows.length, (index) {
      var row = rows[index];
      var toDoId = row["to_do_id"];
      var toDoName = row["to_do_name"];

      return Yapilacaklar(to_do_id: toDoId, to_do_name: toDoName);
    });
  }

  Future<List<Yapilacaklar>> search(String wordOfSearching) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> rows = await db.rawQuery(
        "SELECT * FROM Yapilacaklar WHERE to_do_name like '%$wordOfSearching%'");

    return List.generate(rows.length, (index) {
      var row = rows[index];
      var toDoId = row["to_do_id"];
      var toDoName = row["to_do_name"];

      return Yapilacaklar(to_do_id: toDoId, to_do_name: toDoName);
    });
  }

  Future<void> delete(int toDoId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("Yapilacaklar", where: "to_do_id = ?", whereArgs: [toDoId]);
  }
}
