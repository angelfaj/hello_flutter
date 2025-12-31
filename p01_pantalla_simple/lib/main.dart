import 'package:flutter/material.dart';

void main() {
  runApp(PantallaSimple());
}

class PantallaSimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 100)),
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 4)]),
              child: Image(image: AssetImage('images/cover.jpg'), width: 200),
            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            DescripcionLibro(
              'El despertar de la mente',
              'John Doe',
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            AddBookBtn(),
          ],
        ),
      ),
    );
  }
}

class DescripcionLibro extends StatelessWidget {
  final String titulo;
  final String autor;
  final String sinopsis;

  const DescripcionLibro(this.titulo, this.autor, this.sinopsis, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titulo,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87, fontSize: 30),
        ),
        Text(
          autor,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        Padding(padding: EdgeInsets.only(top: 40)),
        Text(
          sinopsis,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87, fontSize: 10),
          softWrap: true,
        ),
      ],
    );
  }
}

class AddBookBtn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddBookBtnState();
  }
}

class _AddBookBtnState extends State<AddBookBtn> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    var button = isSaved
        //Si es true:
        ? ElevatedButton(
            onPressed: _manageBookInLibrary,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'Eliminar de la biblioteca',
              style: TextStyle(color: Colors.white),
            ),
          )
        //Si es false:
        : ElevatedButton(
            onPressed: _manageBookInLibrary,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              'Añadir a la biblioteca',
              style: TextStyle(color: Colors.white),
            ),
          );

    return Directionality(textDirection: TextDirection.ltr, child: button);
  }

  void _manageBookInLibrary() {
    var newState = !isSaved;

    setState(() {
      isSaved = newState;
    });
  }
}
