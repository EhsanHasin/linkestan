class UrgentNumberMap {
  final int? id;
  final String numberName;
  final String number;
  final String description;
  final String type;
  final int favorite;
  final String createdAt;

  UrgentNumberMap({
    this.id,
    required this.numberName,
    required this.number,
    required this.description,
    required this.type,
    this.favorite = 0,
    required this.createdAt,
  });

  factory UrgentNumberMap.fromMap(Map<String, dynamic> map) {
    return UrgentNumberMap(
      id: map['un_id'],
      numberName: map['un_number_name'],
      number: map['un_number'],
      description: map['un_description'],
      type: map['un_type'],
      favorite: map['un_favorite'],
      createdAt: map['un_created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'un_number_name': numberName,
      'un_number': number,
      'un_description': description,
      'un_type': type,
      'un_favorite': favorite,
      'un_created_at': createdAt,
    };
  }

  UrgentNumberMap copyWith({
     int? id,
     String? numberName,
     String? number,
     String? description,
     String? type,
     int? favorite,
     String? createdAt,
  }) {
    return UrgentNumberMap(
      id: id ?? this.id,
      numberName: numberName ?? this.numberName,
      number: number ?? this.number,
      description: description ?? this.description,
      type: type ?? this.type,
      favorite: favorite ?? this.favorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
