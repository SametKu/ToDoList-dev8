import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/data/entity/yapilacaklar.dart';
import 'package:todo_list/ui/cubit/homepage_cubit.dart';
import 'package:todo_list/ui/views/detail_page.dart';
import 'package:todo_list/ui/views/register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String appBartitle = 'To Do List';
  bool isSearching = false;

  void searchingIs() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().uploadToDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                )).then((value) {
              context.read<HomePageCubit>().uploadToDo();
            });
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(hintText: 'Ara'),
                onChanged: (resultOfSearching) {
                  context.read<HomePageCubit>().search(resultOfSearching);
                },
              )
            : Text(
                appBartitle,
                style: const TextStyle(color: Colors.white),
              ),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    searchingIs();
                    context.read<HomePageCubit>().uploadToDo();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.amber,
                  ))
              : IconButton(
                  onPressed: () {
                    searchingIs();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.amber,
                  )),
        ],
      ),
      body: BlocBuilder<HomePageCubit, List<Yapilacaklar>>(
          builder: ((context, toDoList) {
        if (toDoList.isNotEmpty) {
          return ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              var thing = toDoList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetaySayfa(toDo: thing),
                      )).then((value) {
                    context.read<HomePageCubit>().uploadToDo();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      color: Colors.blue,
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                thing.to_do_name,
                                style: const TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          '${thing.to_do_name} silinsin mi?'),
                                      action: SnackBarAction(
                                          label: 'Evet',
                                          onPressed: () {
                                            context
                                                .read<HomePageCubit>()
                                                .delete(thing.to_do_id);
                                          }),
                                    ));
                                  },
                                  icon: const Icon(Icons.clear))
                            ],
                          ),
                        ),
                      )),
                ),
              );
            },
          );
        } else {
          return const Center();
        }
      })),
    );
  }
}
