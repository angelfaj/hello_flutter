import 'package:flutter_bloc/flutter_bloc.dart';

class BookShelfState {
  List<int> bookIds;
  BookShelfState(this.bookIds);
}

abstract class BookShelfEvent {
  const BookShelfEvent();
}

class AddBookToBookshelf extends BookShelfEvent {
  final int bookId;
  const AddBookToBookshelf(this.bookId);
}

class RemoveBookFromBookshelf extends BookShelfEvent {
  final int bookId;
  const RemoveBookFromBookshelf(this.bookId);
}

class BookshelfBloc extends Bloc<BookShelfEvent, BookShelfState> {
  BookshelfBloc(super.initialState) {
    on<AddBookToBookshelf>((event, emit) {
      state.bookIds.add(event.bookId);
      emit(BookShelfState(state.bookIds));
    });
    on<RemoveBookFromBookshelf>((event, emit) {
      state.bookIds.remove(event.bookId);
      emit(BookShelfState(state.bookIds));
    });
  }
}
