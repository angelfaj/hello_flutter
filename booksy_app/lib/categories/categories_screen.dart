import 'package:booksy_app/model/book_category.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BookCategoriesGrid();
  }
}

class BookCategoriesGrid extends StatelessWidget {
  BookCategoriesGrid({super.key});

  final List<BookCategory> _categories = [
    BookCategory(id: 1, name: "Ciencia Ficción"),
    BookCategory(id: 2, name: "Acción"),
    BookCategory(id: 3, name: "Drama"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: _categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return TileCategory(_categories[index]);
        },
      ),
    );
  }
}

class TileCategory extends StatelessWidget {
  final BookCategory _category;
  const TileCategory(this._category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          //TODO navegar a libros de las categorias
        },
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blue.withOpacity(0.5),
          ),
          child: Text(
            _category.name,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
