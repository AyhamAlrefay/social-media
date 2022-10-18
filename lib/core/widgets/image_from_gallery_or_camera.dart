import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?>imageFromGalleryOrCamera(ImageSource imageSource) async{
  final pickImage=await ImagePicker().pickImage(source: imageSource);
  if(pickImage!=null)
    {
      return File(pickImage.path);
    }
  return null;
}
