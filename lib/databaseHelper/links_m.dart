class LinkMap {
  final int? id;
  final String linkName;
  final String link;
  final String description;
  final String type;
  final int favorite;
  final String createdAt;

  LinkMap({
    this.id,
    required this.linkName,
    required this.link,
    required this.description,
    required this.type,
    this.favorite = 0,
    required this.createdAt,
  });

  factory LinkMap.fromMap(Map<String, dynamic> map) {
    return LinkMap(
      id: map['li_id'],
      linkName: map['li_link_name'],
      link: map['li_link'],
      description: map['li_description'],
      type: map['li_type'],
      favorite: map['li_favorite'],
      createdAt: map['li_created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'li_link_name': linkName,
      'li_link': link,
      'li_description': description,
      'li_type': type,
      'li_favorite': favorite,
      'li_created_at': createdAt,
    };
  }

  LinkMap copyWith({
    int? id,
    String? linkName,
    String? link,
    String? description,
    String? type,
    int? favorite,
    String? createdAt,
  }) {
    return LinkMap(
      id: id ?? this.id,
      linkName: linkName ?? this.linkName,
      link: link ?? this.link,
      description: description ?? this.description,
      type: type ?? this.type,
      favorite: favorite ?? this.favorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
