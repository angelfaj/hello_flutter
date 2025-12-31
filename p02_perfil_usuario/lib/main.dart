import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Perfilea")),
        body: ProfileScreen(),
      ),
      title: "Perfilea",
    ),
  );
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(image: AssetImage('images/gallo.jpg')),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Risu Taca'),
                            Text('The Jungle', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('images/suricata.jpg'),
                        radius: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et"',
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.book, size: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Libros leidos', style: TextStyle(fontSize: 10)),
                        Text(
                          'Número de libros que el usuario ha finalizado',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Text('104', style: TextStyle(fontSize: 30)),
                ],
              ),
            ),
            DefaultTextStyle(
              style: TextStyle(fontSize: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                title: Text('Libros que quiero'),
                subtitle: Text(
                  'Número de libros que el usuario tiene en su lista de deseos',
                ),
                leading: Icon(Icons.book, size: 35),
                trailing: Text('456', style: TextStyle(fontSize: 30)),
              ),
            ),
            Padding(padding: EdgeInsets.all(15)),
            Text('Redes sociales', style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_box, size: 50),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.ac_unit_sharp, size: 50),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.ad_units, size: 50),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Agregar amigo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      'Enviar mensaje',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
