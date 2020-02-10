// William Roberts, collaberator: Anna Jinneman
// 12/5/2019
// Addiley's bouncing ball program. When you click on the canvas
// the ball will teleport to the coordinents and continue bouncing.
//--------------------------------------------------
import 'dart:html';
import 'dart:math';
import 'dart:async';

CanvasElement canvas;
CanvasRenderingContext2D ctx;

//--------------------------------------------------
// Creates canvas and ball. Uses classes game and ball.

void main() {
  canvas = querySelector('#canvas');
  ctx = canvas.getContext('2d');
  var ball1 = new Ball(75,60,15,0,0); //Where ball begins - changes
  var game = new Game(ball1);

  
  canvas.onClick.listen((MouseEvent me) { //Gets X,Y to move the ball to.
    ball1.x = me.page.x - 160; //to get closer to the correct x position.
    ball1.y = me.page.y;
    //new Game()..run();
    
    game.init(ball1);
    game.run();
    
  });  
  
}



//--------------------------------------------------
// Will fill canvas with color, pasting over the old ball
void clear() {
  ctx.save();
  ctx.fillStyle = "rgba(200,0,200,.3)";
  ctx.fillRect(0,0,canvas.width, canvas.height);
  ctx.restore();
}


// Handles velositty, drag, gravity and collisions.
void doTheBall(Ball ball){
  
  //0: Clear Display
  
  clear();
  
  //1: Apply velocity to position (vx -> x)
  
  ball.x += ball.vx;
  ball.y += ball.vy;
  
  
  //2: Apply drag/friction to velocity
  
  ball.vx *= .99;
  ball.vy *= .99;
  
  //3: Apply gravity to velocity
  
  ball.vy += .25;
  ball.vx += .25;
  
  //4 check for collisions
  
  if(ball.y + ball.r > canvas.height){
    ball.y = canvas.height - ball.r;
    ball.vy = -ball.vy.abs();
  }
  if(ball.x + ball.r > canvas.width){
    ball.x = canvas.width - ball.r;
    ball.vx = -ball.vx.abs();
  }
  
  //5 Draws the new Ball
  
  ctx.save();
  ctx.translate(ball.x,ball.y);
  ctx.fillStyle = "#ffff00";
  ctx.beginPath();
  ctx.arc(0,0,ball.r,0,pi * 2, true);
  ctx.closePath();
  ctx.fill();
  ctx.restore();
  
}

//--------------------------------------------------
// Handles what needed for proper game "movement"
class Game{
  
  static const num GAME_SPEED = 7; //Game speed constant
  num _lastTimeStamp = 0;
  
  Ball _ball;
  
  
  Game(Ball ball) {

  init(ball);
}
  
  Future run() async {  //Update frames
  update(await window.animationFrame);
  
}
  
  void init(Ball ball) {
    _ball = ball;
    
  }
  
  //Makes sure the game isn't running faster than it can update.
  void update(num delta) { 
    final num diff = delta - _lastTimeStamp;
    
    if(diff > GAME_SPEED) {
      _lastTimeStamp = delta;
      clear();
      doTheBall(_ball);
    }
    
    run();
    
  }
  
}

class Ball {
  double x; //Start x
  double y; //Start y
  double r; //Radius
  double vx; //Velocity
  double vy; //Velocity

  Ball(this.x, this.y, this.r, this.vx, this.vy);
}

