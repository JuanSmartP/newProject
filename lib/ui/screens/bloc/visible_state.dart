part of 'visible_bloc.dart';

abstract class VisibleState extends Equatable {
  const VisibleState();

  @override
  List<Object> get props => [];
}

class VisibleInitial extends VisibleState {}

class Visible extends VisibleState {
  final bool isVisible;
  const Visible(this.isVisible);
}

class NotVisible extends VisibleState {
  final bool isVisible;
  const NotVisible(this.isVisible);
}
