import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konomic_case/blocs/pancake_swap/pancake_swap_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SelectPicker extends StatefulWidget {
  final text;
  final icon;
  final onTap;
  final value;
  const SelectPicker({super.key, this.text, this.icon, this.onTap, this.value});
  @override
  State<SelectPicker> createState() => _SelectPickerState();
}

class _SelectPickerState extends State<SelectPicker> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  bool first = true;

  @override
  void initState() {
    // ignore: close_sinks

    PancakeSwapBloc pancakeSwapBloc = BlocProvider.of<PancakeSwapBloc>(context);
    pancakeSwapBloc.add(PancakeSwapLoadTokensEvent());
    super.initState();
  }

  TextEditingController serchText = TextEditingController(text: "");
  Map tokens = {};
  List searchList = [];
  bool search = false;

  @override
  Widget build(BuildContext context) {

   return Container(
       height: 60,
       child: InkWell(
           onTap: (){
             showMaterialModalBottomSheet(
               backgroundColor: Colors.transparent,
               context: context,
               builder: (pcontext) {
                 return  SafeArea(
                   child: Container(
                     height: MediaQuery.of(context).size.height * 0.8,
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
                       borderRadius:  BorderRadius.vertical(
                         top: Radius.circular(40),
                       ),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Container(
                           padding: const EdgeInsets.only(
                             top: 4,
                             right: 14,
                             left: 14,
                             bottom: 8,
                           ),

                           child: Center(
                               child: Container(
                                 height: 4,
                                 width: 40,
                                 decoration: const BoxDecoration(
                                   color: Colors.transparent,
                                   borderRadius:  BorderRadius.all(
                                     Radius.circular(40),
                                   ),
                                 ),
                               )),
                         ),
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 14),
                           child: TextField(
                             controller: serchText,
                             onChanged: (query) {

                               if(query.isEmpty){
                                 setState((){
                                   search = false;
                                   searchList = [];
                                 });

                               }else{
                                 setState((){
                                   searchList = ((tokens.values.where((element) => element["name"].contains(query)))).toList();
                                   search = true;

                                   print(searchList);
                                 });

                               }
                             },
                             autofocus: false,
                             decoration: InputDecoration(
                               icon: const Icon(
                                 Icons.search,
                               ),
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey.shade300),
                               ),
                               hintText: 'Поиск',
                             ),
                           ),
                         ),
                         Expanded(
                           child: Container(
                             child: BlocBuilder<PancakeSwapBloc, PancakeSwapState>(
                                 builder: (context, state) {
                                   if (state is PancakeSwapLoadedState) {
                                     var items = state.loaded;
                                     tokens = items["data"];
                                     return Scrollbar(
                                       thickness: 10,
                                       child: search ?
                                       ListView.builder(
                                           itemCount: searchList.length,
                                           itemBuilder: (BuildContext ctxt, int index) {
                                             print("searchList");
                                             print(searchList);
                                             return Column(
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                   child: Material(
                                                     borderRadius: BorderRadius.all(Radius.circular(10)),
                                                     color: Color.fromRGBO(0, 0, 0, 0.05),
                                                     child: InkWell(
                                                       onTap: () {
                                                         setState(() {
                                                           first = false;
                                                         });
                                                         Navigator.of(context).pop();
                                                       },
                                                       child: ListTile(
                                                         title: Text( searchList.elementAt(index)["name"]),
                                                         subtitle: Text(
                                                           searchList.elementAt(index)["symbol"],
                                                           style: TextStyle(color: Colors.grey),
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             );
                                           })
                                           : ListView.builder(
                                           itemCount: tokens.keys.length,
                                           itemBuilder: (BuildContext ctxt, int index) {
                                             tokens[(tokens.keys.elementAt(index))]["token"] = tokens.keys.elementAt(index);
                                             return Column(
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                   child: Material(
                                                     borderRadius: BorderRadius.all(Radius.circular(10)),
                                                     color: Color.fromRGBO(0, 0, 0, 0.05),
                                                     child: InkWell(
                                                       onTap: () {
                                                         setState(() {
                                                           first = false;
                                                         });
                                                         Navigator.of(context).pop();
                                                       },
                                                       child: ListTile(
                                                         title: Text( tokens.values.elementAt(index)["name"]),
                                                         subtitle: Text(
                                                           tokens.values.elementAt(index)["symbol"],
                                                           style: TextStyle(color: Colors.grey),
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             );
                                           }),
                                     );
                                   }
                                   if (state is PancakeSwapLoadingState) {
                                     return const Center(child: CircularProgressIndicator());
                                   }

                                   return const Center(child: Text("Отсутствует интернет!"));
                                 }),
                           ),
                         ),
                       ],
                     ),
                   ),
                 );
               },
             );
           },
           child:  ListTile(
             title: Text(widget.text, style: const TextStyle(fontSize: 30),),
             leading: Icon(widget.icon, size: 30,),
             trailing: const Icon(Icons.arrow_drop_down, size: 30, color: Colors.grey),)));
  }


  Widget ChooseList() {

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
          borderRadius:  BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                top: 4,
                right: 14,
                left: 14,
                bottom: 8,
              ),

              child: Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:  BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                  )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                controller: TextEditingController(text: ""),
                onChanged: (query) {
                  if(query.isEmpty){
                    setState((){
                      search = false;
                      searchList = [];
                    });

                  }else{
                    setState((){
                      searchList = ((tokens.values.where((element) => element["name"].contains(query)))).toList();
                      search = true;

                      print(searchList);
                    });

                  }
                },
                autofocus: false,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.search,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  hintText: 'Поиск',
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: BlocBuilder<PancakeSwapBloc, PancakeSwapState>(
                    builder: (context, state) {
                      if (state is PancakeSwapLoadedState) {
                        var items = state.loaded;
                        tokens = items["data"];
                        return Scrollbar(
                          thickness: 10,
                          child: !search ?
                          ListView.builder(
                              itemCount: searchList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                print("searchList");
                                print(searchList);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Material(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              first = false;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: ListTile(
                                            title: Text( searchList.elementAt(index)["name"]),
                                            subtitle: Text(
                                              searchList.elementAt(index)["symbol"],
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                              : ListView.builder(
                              itemCount: tokens.keys.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                tokens[(tokens.keys.elementAt(index))]["token"] = tokens.keys.elementAt(index);
                                return Column(
                                  children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: Material(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Color.fromRGBO(0, 0, 0, 0.05),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                first = false;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: ListTile(
                                              title: Text( tokens.values.elementAt(index)["name"]),
                                              subtitle: Text(
                                                 tokens.values.elementAt(index)["symbol"],
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                        );
                      }
                      if (state is PancakeSwapLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return const Center(child: Text("Отсутствует интернет!"));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

}