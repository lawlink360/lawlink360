import '../models/client_query_model.dart';

class ClientQueriesData {
  static const List<ClientQueryModel> queries = [
    ClientQueryModel(
      id: 'CQ001',
      title: 'Property Ownership Dispute',
      description:
          'I have a dispute regarding ownership of a family property. I need guidance about the legal procedure and my rights.',
      category: 'Property',
      location: 'Lahore',
      postedTime: '2 hours ago',
      views: 24,
      responses: 3,
    ),

    ClientQueryModel(
      id: 'CQ002',
      title: 'Family Inheritance Matter',
      description:
          'There is a dispute regarding distribution of inherited property among family members. I need legal guidance.',
      category: 'Family',
      location: 'Islamabad',
      postedTime: '5 hours ago',
      views: 18,
      responses: 2,
    ),

    ClientQueryModel(
      id: 'CQ003',
      title: 'Employment Termination Issue',
      description:
          'I was recently terminated from my job and want to know whether I can take legal action against my employer.',
      category: 'Labour',
      location: 'Karachi',
      postedTime: 'Yesterday',
      views: 31,
      responses: 5,
    ),

    ClientQueryModel(
      id: 'CQ004',
      title: 'Criminal Case Legal Guidance',
      description:
          'I have received a legal notice concerning a criminal matter and need advice regarding the next legal steps.',
      category: 'Criminal',
      location: 'Rawalpindi',
      postedTime: 'Yesterday',
      views: 27,
      responses: 4,
    ),

    ClientQueryModel(
      id: 'CQ005',
      title: 'Civil Recovery Claim',
      description:
          'I want to recover money that was given as a loan. Please guide me about the appropriate legal procedure.',
      category: 'Civil',
      location: 'Faisalabad',
      postedTime: '2 days ago',
      views: 15,
      responses: 1,
    ),
  ];
}