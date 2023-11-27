import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/data/entity/yapilacaklar.dart';
import 'package:todo_list/ui/cubit/detail_page_cubit.dart';

class DetaySayfa extends StatefulWidget {
  Yapilacaklar toDo;
  DetaySayfa({super.key, required this.toDo});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfToDoName = TextEditingController();

  @override
  void initState() {
    super.initState();
    var toDo = widget.toDo;
    tfToDoName.text = toDo.to_do_name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      appBar: AppBar(
        title: const Text('To Do Things Detail'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: tfToDoName,
              decoration: InputDecoration(
                  hintText: 'The Name of To Do Thing that is gonna be updated',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                onPressed: () {
                  context
                      .read<DetailPageCubit>()
                      .upgrade(widget.toDo.to_do_id, tfToDoName.text);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
