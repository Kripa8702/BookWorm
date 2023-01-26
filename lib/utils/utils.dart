import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

pickImage(ImageSource imageSource) async {
  ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: imageSource);

  if (file != null) {
    return await file.readAsBytes();
  }

  print("No image selected");
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

useWhiteTextColor(String imageUrl) async {
  PaletteGenerator paletteGenerator =
  await PaletteGenerator.fromImageProvider(
    NetworkImage(imageUrl),

    size: Size(300, 300),

    filters: [],

    region: Rect.fromLTRB(10, 50, 10, 0),
  );

  Color dominantColor = paletteGenerator.dominantColor?.color ?? Colors.white;


  if (dominantColor == null) print('Dominant Color null');
  print(dominantColor);

  Color textColor = dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  print(textColor);

  return textColor;
}
