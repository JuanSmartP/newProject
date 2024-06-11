part of 'changepassword_bloc.dart';

abstract class ChangepasswordEvent extends Equatable {
  const ChangepasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordToNew extends ChangepasswordEvent {
  String oldPassword;
  String repeatOldPassword;
  String newPassword;
  ChangePasswordToNew(
      {required this.oldPassword,
      required this.repeatOldPassword,
      required this.newPassword});
}
