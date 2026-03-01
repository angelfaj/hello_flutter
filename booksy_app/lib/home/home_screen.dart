import 'package:booksy_app/book_details/book_details_screen.dart';
import 'package:booksy_app/model/book.dart';
import 'package:booksy_app/servies/book_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _getLastBooks();
  }

  void _getLastBooks() async {
    var lastBooks = await BooksService().getLastBook();
    setState(() {
      _books = lastBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    var showProgress = _books.isEmpty;
    var listLength = showProgress ? 3 : _books.length + 2;

    return _books.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: listLength,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return HeaderWidget();
                }
                if (index == 1) {
                  return ListItemHeader();
                }
                if (showProgress) {
                  return const Center(child: CircularProgressIndicator());
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
  const ListItemBook(this._book, {super.key});

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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookdDetailsScreen(book)),
    );
  }
}
