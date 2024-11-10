import 'package:flutter/material.dart';

void main() {
  runApp(tictactoe());
}

class tictactoe extends StatefulWidget {
  @override
  _Screen createState() => _Screen();
}

class _Screen extends State<tictactoe> {
  List<String?> board = List.filled(9, null);
  String currentPlayer = 'X';
  String? winner;
  String turn = 'X';

  void move(int index) {
    if (board[index] == null && winner == null) {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner(currentPlayer))
        {
          winner = currentPlayer;
          turn = '';
        }
        else
        {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          if(currentPlayer == 'X')
          {
            turn = 'X';
          }
          else
          {
            turn = 'O';
          }
        }
      });
    }
  }

  bool checkWinner(String player) {
    List<List<int>> winningCombinations = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      //-----------
      [0,3,6],
      [1,4,7],
      [2,5,8],
      //---------------
      [0,4,8],
      [2,4,6]
    ];

    for (var combination in winningCombinations) {
      if (board[combination[0]] == player && board[combination[1]] == player && board[combination[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, null);
      currentPlayer = 'X';
      winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe                    Developer: Zeyad Maged',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => move(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Center(
                    child: Text(
                      board[index] ?? '',
                      style: TextStyle(fontSize: 100),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 30),
          if (winner != null)
            Text(
              'The Winner is $winner !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
              if(turn != '')
              Text(
                'Its $turn Turn',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Reset Game', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}
//Zeyad Maged