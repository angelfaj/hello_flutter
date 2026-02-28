import 'package:booksy_app/model/book_category.dart';
import 'package:booksy_app/utils.dart';
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
    BookCategory(id: 1, name: "Ciencia Ficción", colorBg: "A99CCE3"),
    BookCategory(id: 2, name: "Acción", colorBg: "F0B3E1"),
    BookCategory(id: 3, name: "Drama", colorBg: "#C5F0B3"),
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
          _navigateToBooksWithCategory();
        },
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: hexToColor(_category.colorBg),
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

  void _navigateToBooksWithCategory() {
    // TODO navegr a pantalla de lista de libros de la categoria
  }
}
