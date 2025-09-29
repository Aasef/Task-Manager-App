import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class PhotoPicker extends StatelessWidget {
  const PhotoPicker({
    super.key, required this.onTap, this.selectedPhoto,
  });
  final VoidCallback onTap;
  final XFile? selectedPhoto;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6),
                    bottomLeft:Radius.circular(6))
            ),
            alignment: Alignment.center,
            child: Text(
                selectedPhoto==null?
                'No file detected':selectedPhoto!.name),

          ),
          Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6),
                    bottomLeft:Radius.circular(6))
            ),
            alignment: Alignment.center,
            child: Text('Photo',style: TextStyle(
                color: Colors.white
            ),),
          )

        ],
      ),
    );
  }

}