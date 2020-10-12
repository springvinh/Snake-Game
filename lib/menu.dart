import 'package:flutter/material.dart';
import 'package:snake/game.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24.0),
        width: double.infinity,
        color: Color(0xff0336ff),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenHeight * 0.5),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300.0,
                    child: Center(child: Text('Snake', style: TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold, color: Colors.white),)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Game()));
                    },
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    color: Color(0xffffde03),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('NEW GAME', style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ) 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
