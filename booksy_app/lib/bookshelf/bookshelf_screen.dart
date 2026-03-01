import 'package:booksy_app/book_details/book_details_screen.dart';
import 'package:booksy_app/model/book.dart';
import 'package:booksy_app/servies/book_services.dart';
import 'package:booksy_app/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({super.key});

  // final List<Book> _books = const [
  //   Book(
  //     1,
  //     "Gomorra",
  //     "Roberto Saviano",
  //     "Los entresijos de la mafia italiana",
  //     "assets/images/gomorra.jpg",
  //   ),
  //   Book(
  //     2,
  //     "Noches blancas",
  //     "Fiodor Dostoyevski",
  //     "Novela corta",
  //     "assets/images/noches_blancas.jpg",
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfBloc, BookShelfState>(
      builder: (context, bookShelfState) {
        if (bookShelfState.bookIds.isEmpty) {
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
            itemCount: bookShelfState.bookIds.length,
            itemBuilder: (context, index) {
              return BookCoverItem(bookShelfState.bookIds[index]);
            },
          ),
        );
      },
    );
  }
}

class BookCoverItem extends StatefulWidget {
  final int _bookId;
  const BookCoverItem(this._bookId, {super.key});

  @override
  State<BookCoverItem> createState() => _BookCoverItemState();
}

class _BookCoverItemState extends State<BookCoverItem> {
  Book? _book;

  @override
  void initState() {
    super.initState();
    _getBook(widget._bookId);
  }

  void _getBook(int bookId) async {
    var book = await BooksService().getBook(bookId);
    setState(() {
      _book = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_book == null) {
      return Center(child: CircularProgressIndicator());
    }
    return InkWell(
      onTap: () {
        _openBookDetails(_book!, context);
      },
      child: Ink.image(fit: BoxFit.fill, image: AssetImage(_book!.coverUrl)),
    );
  }

  void _openBookDetails(Book book, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookdDetailsScreen(book)),
    );
  }
}
