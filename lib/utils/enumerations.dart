enum Entity { clinic, room, service }

String entityToString(Entity entity) {
  switch (entity) {
    case Entity.clinic:
      return 'clinics';
    case Entity.room:
      return 'rooms';
    case Entity.service:
      return 'services';
    default:
      return 'Entity Enum';
  }
}
