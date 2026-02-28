import 'package:booksy_app/model/book.dart';
import 'package:flutter/material.dart';

class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({Key? key}) : super(key: key);

  final List<Book> _books = const [
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

  @override
  Widget build(BuildContext context) {
    if (_books.isEmpty) {
      return Center(
        child: Text(
          "Aún no tienes libros en tu estante",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container(
      margin: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return BookCoverItem(_books[index]);
        },
      ),
    );
  }
}

class BookCoverItem extends StatelessWidget {
  final Book _book;
  const BookCoverItem(this._book, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink.image(fit: BoxFit.fill, image: AssetImage(_book.coverUrl)),
    );
  }
}
