# cs441_assignment3

In this project, I recreated a version of the famous game pong. The main difference
is that this game is a single player game as opposed to a two person game. You
are competing for a high score and not against another player. I created two
SKNodes, the paddle and the ball. The sides of the screen are also a SKPhysicsBody
that the ball can bounce off of. The number on the top is a timer that increments
by 1 second every second using NSTimer. This is also your score. And the text
in the middle is your high score and updates everytime you get a new high score.
Another tweak to the game is that every second the velocity of the ball goes up
1 percent so that the game does get harder the longer you can stay alive. The 
game ends when the ball goes past your paddle into the top side of the screen.
When that happens the ball spawns back in the middle and you can initiate it 
by just clicking on it. 
