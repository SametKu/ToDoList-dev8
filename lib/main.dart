import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/ui/cubit/detail_page_cubit.dart';
import 'package:todo_list/ui/cubit/homepage_cubit.dart';
import 'package:todo_list/ui/cubit/register_page_cubit.dart';
import 'package:todo_list/ui/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterPageCubit(),
        ),
        BlocProvider(
          create: (context) => DetailPageCubit(),
        ),
        BlocProvider(
          create: (context) => HomePageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
