import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageDataSources{
  final FirebaseStorage firebaseStorage;

  FirebaseStorageDataSources({required this.firebaseStorage});
  Future<String> storeFileToFirebase(String ref,File file )async{
  UploadTask uploadTask=FirebaseStorage.instance.ref().child(ref).putFile(file);
  TaskSnapshot snapshot=await uploadTask;
  String url=await snapshot.ref.getDownloadURL();
  return url;
  }
}