import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konomic_case/blocs/pancake_swap/pancake_swap_bloc.dart';
import 'package:konomic_case/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PancakeSwapBloc>(
          create: (BuildContext context) => PancakeSwapBloc(),
        ),
      ],
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: 'Choose tokens',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.deepPurple,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.transparent,
            primaryColor: Colors.black,
            textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Colors.white),
            ),),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, centerTitle: true)
          ),
          home: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color.fromRGBO(48, 50, 81, 1),
                    Color.fromRGBO(39, 41, 61, 1),
                    Color.fromRGBO(33, 34, 56, 1),
                    Color.fromRGBO(32, 33, 54, 1),
                  ],
                ),
              ),
              child: const MyHomePage(title: 'Choose tokens')),
        ),
      ),
    );
  }
}
