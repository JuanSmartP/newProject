part of 'redes_bloc.dart';

abstract class RedesEvent extends Equatable {
  const RedesEvent();

  @override
  List<Object> get props => [];
}

class getRedes extends RedesEvent {
  getRedes();
}

class goWhatsapp extends RedesEvent {
  String number;
  goWhatsapp({required this.number});
}
