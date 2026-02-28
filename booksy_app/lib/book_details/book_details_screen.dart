import 'package:booksy_app/model/book.dart';
import 'package:booksy_app/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookdDetailsScreen extends StatelessWidget {
  final Book _book;
  const BookdDetailsScreen(this._book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalle libro")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookCoverWidget(_book.coverUrl),
            BookInfoWidget(_book.title, _book.author, _book.description),
            BookActionsWidget(_book.id),
          ],
        ),
      ),
    );
  }
}

class BookActionsWidget extends StatelessWidget {
  final int bookId;
  const BookActionsWidget(this.bookId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfBloc, BookShelfState>(
      builder: (context, bookShelfState) {
        void action() => _addToBookshelf(context, bookId);
        var label = "Agregar al estante";
        var color = Colors.green;

        if (bookShelfState.bookIds.contains(bookId)) {
          // ignore: unused_element
          action() => _removeBookFromBookshelf(context, bookId);
          label = "Eliminar del estante";
          color = Colors.red;
        }

        return ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(label),
        );
      },
    );
  }

  void _addToBookshelf(BuildContext context, int bookId) {
    var bookshelfBloc = context.read<BookshelfBloc>();
    bookshelfBloc.add(AddBookToBookshelf(bookId));
  }

  void _removeBookFromBookshelf(BuildContext context, int bookId) {
    var bookshelfBloc = context.read<BookshelfBloc>();
    bookshelfBloc.add(RemoveBookFromBookshelf(bookId));
  }
}

class BookInfoWidget extends StatelessWidget {
  final String title;
  final String author;
  final String description;

  const BookInfoWidget(this.title, this.author, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Text(author, style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 20),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class BookCoverWidget extends StatelessWidget {
  final String _coverUrl;
  const BookCoverWidget(this._coverUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      width: 200,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
          ),
        ],
      ),
      child: Image.asset(_coverUrl),
    );
  }
}
