import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(title: 'App de testeo de componentes', home: ListViewScreen()),
  );
}

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listas con ListView')),
      body: ListViewWidgetsWithBuilderAndTappable(),
    );
  }
}

class ListViewWidgets extends StatelessWidget {
  const ListViewWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        Container(
          height: 40,
          color: Colors.amber,
          child: Center(child: Text('Fila 1')),
        ),
        Container(
          height: 40,
          color: Colors.blueGrey,
          child: Center(child: Text('Fila 2')),
        ),
        Container(
          height: 40,
          color: Colors.orangeAccent,
          child: Center(child: Text('Fila 3')),
        ),
        Container(
          height: 40,
          color: Colors.redAccent,
          child: Center(child: Text('Fila 4')),
        ),
      ],
    );
  }
}

class ListViewWidgetsWithBuilderAndTappable extends StatelessWidget {
  ListViewWidgetsWithBuilderAndTappable({super.key});

  final List<String> rowsStrings = ['A', 'B', 'C', 'D'];
  final List<int> colorCodes = [500, 400, 300, 200];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: rowsStrings.length,
      itemBuilder: (context, index) {
        return InkWell(
          splashColor: Colors.blue,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Fila ${rowsStrings[index]} te saluda!')),
            );
          },
          child: ListTile(
            title: Center(child: Text('Fila ${rowsStrings[index]}')),
            tileColor: Colors.amber[colorCodes[index]],
          ),
        );
      },
    );
  }
}


/* IMAGENES
class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imágenes')),
      body: ImagesList(),
    );
}

class ImagesList extends StatelessWidget {
  const ImagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: Image(image: AssetImage('images/gallo.jpg')),
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: Image(image: AssetImage('images/suricata.jpg')),
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: Image(image: AssetImage('images/cover.jpg')),
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: Image.network(
              'https://files.maldita.es/maldita/uploads/undated/foto%20gorila%20broma.jpg',
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/

/* BOTONES FLOTANTES
class _FloatingActionButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flotating action button')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //hacer algo
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}

class _FloatingActionButtonExtendedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flotating action button')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Compartir'),
        icon: const Icon(Icons.share),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
*/

// class HolaFlutter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var widgetTxt = Text(
//       "Hola hola",
//       textDirection: TextDirection.ltr,
//       style: TextStyle(fontSize: 32),
//     );

//     var widgetCenter = Center(child: widgetTxt);

//     return widgetCenter;
//   }
// }



/* 
  List<int> puntuaciones = [1, 0, 10, 6, 9];
  var aprobados = puntuaciones.where((puntuacion) => puntuacion > 5);
  
  for (var puntuacion in aprobados) {
    print(puntuacion);
  }

  String? name;
  name = "hola";
  name.length; */

