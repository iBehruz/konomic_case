part of 'pancake_swap_bloc.dart';

@immutable
abstract class PancakeSwapEvent {}

class PancakeSwapLoadTokensEvent extends PancakeSwapEvent {}
class PancakeSwapSearchTokensEvent extends PancakeSwapEvent {
  final String query;
  final Map list;
  PancakeSwapSearchTokensEvent({required this.query, required this.list});
}
