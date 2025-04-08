import 'package:intl/intl.dart';

class Forum {
  final int id;
  final String judulForum;
  final String deskripsiForum;
  final String tanggal;
  final List<String> imageUrls;
  final int userId;

  Forum({
    required this.id,
    required this.judulForum,
    required this.deskripsiForum,
    required this.tanggal,
    required this.imageUrls,
    required this.userId,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    List<dynamic> images = json['images'];
    List<String> imageUrls =
        images.map((image) => image['url'] as String).toList();

    DateTime createdAt = DateTime.parse(json['created_at']);
    final formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    final formattedDate = formatter.format(createdAt);

    return Forum(
      id: json['id_forums'],
      judulForum: json['title'],
      deskripsiForum: json['deskripsi'],
      tanggal: formattedDate,
      imageUrls: imageUrls,
      userId: int.parse(json['user_id']),
    );
  }
}
