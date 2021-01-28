enum Book { clinic, room, service }

String bookToString(Book book) {
  switch (book) {
    case Book.clinic:
      return 'clinics';
    case Book.room:
      return 'rooms';
    case Book.service:
      return 'services';
    default:
      return 'Book Enum';
  }
}
