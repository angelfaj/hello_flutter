import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'App de testeo de componentes',
        home: Scaffold(
          // appBar: AppBar(title: const Text('Simple Riverpod app')),
          body: const MenuScreen(),
        ),
        //ROutes es para mapas estaticos, si queremos logica y validaciones debemos utilizar onGenerateRoute
        routes: <String, WidgetBuilder>{
          '/user_profile': (context) => UserProfileScreen(""),
        },
        onGenerateRoute: (settings) {
          if (settings.name!.contains('user_profile')) {
            //Argumentos pasados por arguments
            // final args = settings.arguments;

            // Argumentos pasados por ruta: /user_profile/user_id
            var uri = Uri.parse(settings.name!);
            if (uri.pathSegments.length >= 2) {
              var id = uri.pathSegments[1];
              return MaterialPageRoute(
                builder: (context) => UserProfileScreen(id),
              );
            }
          }
        },
      ),
    ),
  );
}

//Navegacion de pantallas con Navigation API
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                //Navegar a otra pantalla
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
              child: const Text('Abrir siguiente pantalla'),
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                //Navegar a otra pantalla
                //Pasando argumentos con arguments (seguridad y validacion)
                // Navigator.pushNamed(
                //   context,
                //   '/user_profile',
                //   arguments: 'manolitogafotas',
                // );

                //Alternativa pasando los argumentos en la ruta (mayor legibilidad)
                Navigator.pushNamed(context, '/user_profile/manolitogafotas');
              },
              child: const Text('Abrir perfil usuario'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Volver a la pantalla anterior
            Navigator.pop(context);
          },
          child: const Text('Volver'),
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  final String _userID;
  const UserProfileScreen(this._userID, {super.key});

  @override
  Widget build(BuildContext context) {
    //final userID = ModalRoute.of(context)!
    //    .settings
    //    .arguments; //Logica que permite recoger los args pasados por parametro

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil usuario')),
      body: Column(
        children: [
          Text('Manolito gafotas, userID pasado por parametro= $_userID'),
          ElevatedButton(
            onPressed: () {
              //Volver a la pantalla anterior
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

//Gestion de estados con Riverpod
//Clase padre de settings
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estados con Riverpod')),
      body: Column(children: [ColorSelection(), ColoredBox()]),
    );
  }
}

//Este es el estado
class ColorSettings {
  final bool useRed;
  const ColorSettings(this.useRed);
}

//Este el StateNotifier, donde deben realizarse los cambios en el estado
class ColorSettingsNotifier extends StateNotifier<ColorSettings> {
  ColorSettingsNotifier(super.state);

  void setRed() {
    state = const ColorSettings(true); //Nueva instancia con el nuevo estado
  }

  void unsetRed() {
    state = const ColorSettings(false); //Nueva instancia cn el nuevo estado
  }
}

//StateNotifierProvider
final colorSettingsProvider =
    StateNotifierProvider<ColorSettingsNotifier, ColorSettings>(
      (_) => ColorSettingsNotifier(const ColorSettings(false)),
    );

class ColorSelection extends ConsumerWidget {
  const ColorSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorSettings = ref.watch(colorSettingsProvider);
    return Row(
      children: [
        Checkbox(
          value: colorSettings.useRed,
          onChanged: (isChecked) => {
            onCheckBoxPressed(isChecked, ref, context),
          },
        ),
        const Text('Rojo'),
      ],
    );
  }

  void onCheckBoxPressed(bool? isChecked, WidgetRef ref, BuildContext context) {
    var colorSettingsNotifier = ref.read(colorSettingsProvider.notifier);

    if (isChecked!) {
      colorSettingsNotifier.setRed();
    } else {
      colorSettingsNotifier.unsetRed();
    }
  }
}

class ColoredBox extends ConsumerWidget {
  const ColoredBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorSettings = ref.watch(colorSettingsProvider);

    return Container(
      color: colorSettings.useRed ? Colors.red : Colors.black38,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
    );
  }
}

//Navegacion de pantallas con navigation bar
//Lamando a esta clase desde MarialApp home: obtenemos una app sencilla de navegacion entre pantallas
class BottomNavigationBarDemoScreen extends StatefulWidget {
  const BottomNavigationBarDemoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarDemoScreenState();
}

class _BottomNavigationBarDemoScreenState
    extends State<BottomNavigationBarDemoScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screen = [
    SettingsScreen(),
    ListViewScreen(),
    ImagesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomNavigationBar simple')),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Work'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Pictures'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _screen[_selectedIndex],
    );
  }
}

//  IMAGENES
class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imágenes')),
      body: ImagesList(),
    );
  }
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
          // Padding(
          //   padding: EdgeInsets.all(40),
          //   child: Image.network(
          //     'https://files.maldita.es/maldita/uploads/undated/foto%20gorila%20broma.jpg',
          //     loadingBuilder: (context, child, loadingProgress) {
          //       if (loadingProgress == null) return child;
          //       return Center(child: CircularProgressIndicator());
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

// BOTONES FLOTANTES
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

//  LISTAS
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

