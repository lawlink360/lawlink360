class ClientQueryModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String location;
  final String postedTime;
  final int views;
  final int responses;

  const ClientQueryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.postedTime,
    required this.views,
    required this.responses,
  });
}