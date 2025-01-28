import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class FirebaseStorageService {
  Future<List<String>> subirFotos(List<Uint8List> fotos) async {
    List<String> urls = [];
    try {
      for (int i = 0; i < fotos.length; i++) {
        String fileName = 'auto_${DateTime.now().millisecondsSinceEpoch}_$i.png';
        Reference storageRef = FirebaseStorage.instance.ref().child('imagenes/$fileName');
        UploadTask uploadTask = storageRef.putData(fotos[i]);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        urls.add(downloadUrl);
      }
    } catch (e) {
      print('Error al subir imágenes: $e');
    }
    return urls; // Retorna las URLs de las imágenes subidas
  }
}
