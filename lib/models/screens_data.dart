import 'card_data.dart';
import '../utils/enumerations.dart';

class AvailableScreenData {
  final Map<String, dynamic> name;
  final Entity entity;

  AvailableScreenData(this.name, this.entity);
}

class BookNowScreenData {
  final CardData card;
  final bool entity;
  BookNowScreenData(this.entity, this.card);
}
