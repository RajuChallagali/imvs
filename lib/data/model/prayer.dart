class Prayer {
  final int id;
  final String title;
  final String description;
  

  Prayer({
    required this.id,
    required this.title,
    required this.description,
    
  });

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      description: json['description'],
    );
  }
}