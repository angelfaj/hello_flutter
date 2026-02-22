import 'package:booksy_app/model/book.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
    return Container(
      margin: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _books.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return HeaderWidget();
          }
          if (index == 1) {
            return ListItemHeader();
          }
          return ListItemBook(_books[index - 2]);
        },
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/images/libraryHeader.jpg'),
    );
  }
}

class ListItemHeader extends StatelessWidget {
  const ListItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 5),
      child: Text("Últimos libros", style: TextStyle(fontSize: 20)),
    );
  }
}

class ListItemBook extends StatelessWidget {
  final Book _book;
  const ListItemBook(this._book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 170,
        child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: () {
            _openBookDetails(context, _book);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Image.asset(_book.coverUrl),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        _book.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _book.author,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _book.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openBookDetails(BuildContext context, Book book) {
    //TODO navegar a la descripcion del libro
  }
}
