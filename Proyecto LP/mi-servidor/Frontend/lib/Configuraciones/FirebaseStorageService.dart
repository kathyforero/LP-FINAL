import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> subirFotos(List<Uint8List> imagenes) async {
    List<String> urls = [];

    for (Uint8List imagen in imagenes) {
      try {
        String filePath = "autos/${DateTime.now().millisecondsSinceEpoch}.png";
        Reference ref = _storage.ref().child(filePath);

        SettableMetadata metadata = SettableMetadata(contentType: "image/png");

        UploadTask uploadTask = ref.putData(imagen, metadata);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});

        String url = await snapshot.ref.getDownloadURL();
        urls.add(url);
      } catch (e) {
        print("Error al subir imagen: $e");
        return [];
      }
    }

    return urls;
  }
}
