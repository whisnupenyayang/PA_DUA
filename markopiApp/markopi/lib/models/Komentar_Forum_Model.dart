import 'package:intl/intl.dart';

class KomentarForum {
  int id_forum_komentars;
  int user_id;
  int forum_id;
  String komentar;
  String created_at;
  String updated_at;

  KomentarForum({
    required this.id_forum_komentars,
    required this.user_id,
    required this.forum_id,
    required this.komentar,
    required this.created_at,
    required this.updated_at,
  });

  factory KomentarForum.fromJson(Map<String, dynamic> json) {
    DateTime dateCreated = DateTime.parse(json['created_at']);

    DateTime dateUpdated = DateTime.parse(json['updated_at']);

    final formater = DateFormat('dd MMMM yyyy', 'id_ID');
    final formattedDateCreated = formater.format(dateCreated);
    final formatedDateUpdated = formater.format(dateUpdated);

    return KomentarForum(
      id_forum_komentars: json['id_forum_komentars'],
      user_id: json['user_id'],
      forum_id: json['forum_id'],
      komentar: json['komentar'],
      created_at: formattedDateCreated,
      updated_at: formatedDateUpdated,
    );
  }
}
