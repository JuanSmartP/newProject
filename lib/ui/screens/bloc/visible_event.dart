part of 'visible_bloc.dart';

abstract class VisibleEvent extends Equatable {
  const VisibleEvent();

  @override
  List<Object> get props => [];
}

class setVisibility extends VisibleEvent {
  bool isvisible;
  setVisibility({required this.isvisible});
}
