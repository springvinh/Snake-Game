import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake/menu.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<int> snakePosition = [45,46,47,48];
  int food;
  int score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame(context);
  }

  void startGame(BuildContext context) {

    food = Random().nextInt(699);

    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {

      updateSnake();

      if (gameOver()) {

        timer.cancel();

        Navigator.pop(context);
        
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Gameover'),));

      }

    });

  }

  var direction = 'right';
  void updateSnake() {

    setState(() {
      
      switch (direction) {
        case 'down': 

          snakePosition.last > 680 ? snakePosition.add(snakePosition.last + 20 - 700) :
          snakePosition.add(snakePosition.last + 20);

        break;

        case 'up': 

          snakePosition.last < 20 ? snakePosition.add(snakePosition.last - 20 + 700) :
          snakePosition.add(snakePosition.last - 20);

        break;

        case 'left': 

          snakePosition.last % 20 == 0 ? snakePosition.add(snakePosition.last - 1 + 20) :
          snakePosition.add(snakePosition.last - 1);

        break;

        case 'right': 

          (snakePosition.last + 1) % 20 == 0 ? snakePosition.add(snakePosition.last + 1 - 20) :
          snakePosition.add(snakePosition.last + 1);

        break;


        default:
      }

      if (snakePosition.contains(food)) {

        createFood();
        score+=1;

      } else {

        snakePosition.remove(snakePosition.first);

      }

    });

  }

  void createFood() {

    food = Random().nextInt(699);

    if (snakePosition.contains(food)) {

      createFood();

    }

  }

  bool gameOver() {

    int count;

    for (int i = 0; i < snakePosition.length; i++) {
      count = 0;

      for (int j = 0; j < snakePosition.length; j++) {

        if (snakePosition[i] == snakePosition[j]) count+=1;

      }

      if (count == 2) return true;

    }

    return false;

  }



  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Color(0xff0336ff),
          height: double.infinity,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenHeight * 0.5),
              child: SafeArea(
                child: GestureDetector(

                  onVerticalDragUpdate: (details) {
                    
                    if(direction != 'up' && details.delta.dy > 0) {
                      direction = 'down';
                    } else if (direction != 'down' && details.delta.dy < 0) {
                      direction = 'up';
                    }
                    
                  },
                  onHorizontalDragUpdate: (details) {

                    if(direction != 'left' && details.delta.dx > 0) {
                      direction = 'right';
                    } else if (direction != 'right' && details.delta.dx < 0) {
                      direction = 'left';
                    }
                   
                  },

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 700,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 20),
                        itemBuilder: (context, index) {

                          return Container(
                            margin: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: food == index ? Color(0xfffe0265) : snakePosition.contains(index) ? snakePosition.last == index ? Color(0xffffde03) : Colors.white : Color.fromRGBO(255, 255, 255, 0.05)
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text('SCORE: $score', style: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}