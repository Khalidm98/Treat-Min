enum Book { clinic, room, service }

String bookToString(Book book) {
  switch (book) {
    case Book.clinic:
      return 'Outpatient Clinics';
    case Book.room:
      return 'Special Rooms';
    case Book.service:
      return 'Services';
    default:
      return 'Book Enum';
  }
}

enum Language { Arabic, English }
