
import "package:image_picker/image_picker.dart";


pickerImage(ImageSource source) async {
  final ImagePicker _image = ImagePicker();
  XFile? _file = await _image.pickImage(source: source);

  if(_file != null){
    return await _file.readAsBytes();
  }
  print("No image");
}