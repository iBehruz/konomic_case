part of 'pancake_swap_bloc.dart';

@immutable
abstract class PancakeSwapState {}

class PancakeSwapInitial extends PancakeSwapState {}
class PancakeSwapLoadingState extends PancakeSwapState {}
class PancakeSwapLoadedState extends PancakeSwapState {
  final loaded;
  PancakeSwapLoadedState({this.loaded});
}
class PancakeSwapErrorState extends PancakeSwapState {}
