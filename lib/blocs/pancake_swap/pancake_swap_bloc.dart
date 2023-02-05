import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'pancake_swap_event.dart';
part 'pancake_swap_state.dart';

class PancakeSwapBloc extends Bloc<PancakeSwapEvent, PancakeSwapState> {
  PancakeSwapBloc() : super(PancakeSwapInitial()) {
    on<PancakeSwapEvent>((event, emit) async {
      emit(PancakeSwapLoadingState());
        if(event is PancakeSwapLoadTokensEvent){
          final response = await http.get(
            Uri.parse("https://api.pancakeswap.info/api/tokens"),
          );
         return emit(PancakeSwapLoadedState(loaded: jsonDecode(response.body)));
        }

       return emit(PancakeSwapErrorState());
    });
  }
}
