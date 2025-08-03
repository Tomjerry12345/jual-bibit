import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseServices {
  final supabase = Supabase.instance.client;

  Future uploadFile(
      Uint8List file, String buckets, String path, String fileName) async {
    final fullPath = '$path/$fileName';
    await supabase.storage.from(buckets).uploadBinary(
          fullPath,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    final String publicUrl =
        supabase.storage.from(buckets).getPublicUrl(fullPath);
    return publicUrl;
  }
}
