part of 'save_user_data_bloc.dart';
abstract class SaveUserDataEvent{}
class SaveUserData extends SaveUserDataEvent{
 final String name;
  final File profilePic;

 SaveUserData({
   required this.name,
   required this.profilePic,
  });
}
class GetUserData extends SaveUserDataEvent{
}