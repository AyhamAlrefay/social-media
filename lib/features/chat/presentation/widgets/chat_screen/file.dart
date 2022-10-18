import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../core/strings/string_public.dart';
class FilePage extends StatefulWidget {
  final List<PlatformFile>files;
  final ValueChanged<PlatformFile>onOpendFile;
  const FilePage({Key? key, required this.files, required this.onOpendFile}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(ALL_FILES),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
            padding:const EdgeInsets.all(16),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: widget.files.length,
            itemBuilder: (context,index){
              final file=widget.files[index];
              return buildFile(file);
            },
        ),
      ),
    );
  }
  Widget buildFile(PlatformFile file){
    final kb=file.size/1024;
    final mb=kb/1024;
    final fileSize='${mb.toStringAsFixed(2)} MB';
    final extension=file.extension??'none';
    const color=Colors.blue;
    return InkWell(
      onTap: ()=>widget.onOpendFile(file),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),

              ),
              child: Text(
                '.$extension',
                style:const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ),
            const SizedBox(height: 8,),
            Text(
              file.name,
              style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            ),
            Text(
             fileSize,
              style:const TextStyle(fontSize:16),

            ),

          ],
        ),
      ),
    );
  }
}

