class Replies {
  final int id;
  final int userId;
  final int komentarId; // This is defined as int
  final String komentar;

  Replies({
    required this.id,
    required this.userId,
    required this.komentarId,
    required this.komentar,
  });

  factory Replies.fromJson(Map<String, dynamic> json) {
    return Replies(
      id: json['id'],
      userId: int.parse(json['user_id']),
      komentarId:
          json['komentar_id'], // This value needs to be parsed correctly
      komentar: json['komentar'],
    );
  }
}
