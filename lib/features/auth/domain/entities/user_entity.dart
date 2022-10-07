class User{
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;

  User(
      {required this.name,
      required this.uid,
      required this.profilePic,
      required this.isOnline,
      required this.phoneNumber,
      required this.groupId});


}