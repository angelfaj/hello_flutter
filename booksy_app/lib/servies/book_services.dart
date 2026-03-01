import 'package:booksy_app/model/book.dart';

class BooksService {
  static const List<Book> books = [
    Book(
      1,
      "Gomorra",
      "Roberto Saviano",
      "Los entresijos de la mafia italiana",
      "assets/images/gomorra.jpg",
    ),
    Book(
      2,
      "Noches blancas",
      "Fiodor Dostoyevski",
      "Novela corta",
      "assets/images/noches_blancas.jpg",
    ),
  ];

  Future<List<Book>> getLastBook() async {
    // var books = await api.getBooks();
    return Future.delayed(
      const Duration(seconds: 2),
    ).then((value) => Future.value(books.sublist(0, 2)));
  }

  Future<Book> getBook(int bookId) async {
    // var books = await api.getBooks();
    return Future.delayed(const Duration(seconds: 2)).then(
      (value) => Future.value(
        books.firstWhere((bookElement) => bookElement.id == bookId),
      ),
    );
  }
}
