part of 'save_user_data_bloc.dart';

abstract class SaveUserDataState {}

class SaveUserDataStateInitial extends SaveUserDataState {}

class SaveUserDataStateLoading extends SaveUserDataState {}

class SaveUserDataStateSuccess extends SaveUserDataState {}

class SaveUserDataStateError extends SaveUserDataState {
  final String error;

  SaveUserDataStateError({required this.error});
}
class GetUserDataStateLoading extends SaveUserDataState{}
class GetUserDataStateError extends SaveUserDataState{
  final String error;

  GetUserDataStateError({required this.error});
}
class GetUserDataStateSuccess extends SaveUserDataState{
  final UserEntity user;

  GetUserDataStateSuccess({required this.user});
}
