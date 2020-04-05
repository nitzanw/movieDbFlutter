import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    this.text,
    this.callback,
  });

  final int text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: callback,
        child: new Card(
            color: Colors.blue.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: Colors.amber,
                  child: Image.asset(
                    'images/movie_icon.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'tile $text',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
