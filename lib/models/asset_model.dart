class Asset {
  final int? id;
  final String qrId;
  final String name;
  final String type;
  final String? summary;
  final String imagePath;
  final DateTime createdAt;

  Asset({
    this.id,
    required this.qrId,
    required this.name,
    required this.type,
    this.summary,
    required this.imagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qrId': qrId,
      'name': name,
      'type': type,
      'summary': summary,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'],
      qrId: map['qrId'],
      name: map['name'],
      type: map['type'],
      summary: map['summary'],
      imagePath: map['imagePath'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
