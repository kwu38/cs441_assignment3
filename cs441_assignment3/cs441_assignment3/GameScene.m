//
//  GameScene.m
//  cs441_assignment3
//
//  Created by Kevin Wu on 2/17/19.
//  Copyright © 2019 Kevin Wu. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene {
    NSTimer* time;
    SKLabelNode* timer, *high_score;
    SKSpriteNode* ball;
    SKNode* playerPaddle;
    SKPhysicsBody* border;
    SKSpriteNode* background;
    Boolean paddleTouched;
    int counter, flag, previous_score;
}

- (void)didMoveToView:(SKView *)view {
    counter = 0.0;
    flag = 1;
    paddleTouched = false;
    background = [SKSpriteNode spriteNodeWithImageNamed:@"court.jpg"];
    timer = [SKLabelNode labelNodeWithFontNamed: @"ArialMT"];
    timer.fontSize = 36;
    timer.text = @"0";
    CGPoint scorePosition = CGPointMake(0, (self.frame.size.height) / 2.20);
    timer.position = scorePosition;
    [self addChild: timer];
    high_score = [SKLabelNode labelNodeWithFontNamed: @"ArialMT"];
    high_score.fontSize = 72;
    high_score.text = @"high score: 0";
    CGPoint high_pos = CGPointMake(0, 10);
    high_score.position = high_pos;
    [self addChild: high_score];
    background.size = self.frame.size;
    background.zPosition = -1;
    //background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addChild:background];
    playerPaddle = [self childNodeWithName:(@"paddle")];
    ball.name = @"ball";
    ball.physicsBody.dynamic = TRUE;
    ball.physicsBody.usesPreciseCollisionDetection = TRUE;
    playerPaddle.name = @"paddle";
    ball.physicsBody.collisionBitMask = 1;
    playerPaddle.physicsBody.categoryBitMask= 2;
    playerPaddle.physicsBody.collisionBitMask = 2;
    playerPaddle.physicsBody.categoryBitMask = 1;
    CGSize size = CGSizeMake(150, 25);
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:((ball.size.width/2))];
    ball.physicsBody.friction = 0;
    ball.physicsBody.restitution = 1;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.angularDamping = 0;
    ball.physicsBody.affectedByGravity = false;
    ball.name = @"theduke";
    ball.userInteractionEnabled = false;
    [self addChild:ball];
    border = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
    border.friction = 0;
    border.restitution = 1;
    border.linearDamping = 0;
    border.angularDamping = 0;
    self.physicsBody = border;
}


- (void)touchDownAtPoint:(CGPoint)pos {
    
}

- (void)touchMovedToPoint:(CGPoint)pos {
    
}

- (void)touchUpAtPoint:(CGPoint)pos {
    
}
- (void)didBeginContact:(SKPhysicsContact*) contact{
    NSLog(@"contact");
    SKPhysicsBody* firstBody;
    SKPhysicsBody* secondBody;
    NSLog(@"contact");
  if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ([firstBody.node.name isEqual: @"paddle"] ||
        [secondBody.node.name isEqual: @"paddle"]) {
        counter;
        timer.text = [NSString stringWithFormat:@"%d", counter];
        }
    
}
- (void)speedUp:(NSTimer *)clock
{
    CGFloat x = ball.physicsBody.velocity.dx * 1.01;
    CGFloat y = ball.physicsBody.velocity.dy * 1.01;
    CGVector impulse = CGVectorMake(x, y);
    ball.physicsBody.velocity = impulse;
    counter++;
    timer.text = [NSString stringWithFormat:@"%d", counter];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode: self];
    SKNode* touchedNode = [self nodeAtPoint:positionInScene];
    if([touchedNode.name isEqualToString:@"theduke"] && flag == 1){
        flag = 0;
        int randomX = arc4random() % 2 ? 1 : -1;
        CGVector impulse = CGVectorMake(randomX*25, -25);
        [touchedNode.physicsBody applyImpulse: impulse];
        time = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(speedUp:)
                                              userInfo:nil
                                               repeats:YES];
    }
    if([touchedNode.name isEqualToString:@"paddle"]){
        paddleTouched = true;
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(paddleTouched){
        UITouch* touch = [touches anyObject];
        CGPoint positionInScene = [touch locationInNode: self];
        playerPaddle.position = CGPointMake(positionInScene.x, playerPaddle.position.y);
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(paddleTouched){
        paddleTouched = false;
    }
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    if(ball.position.y >= playerPaddle.position.y + 100){
        flag = 1;
        ball.position = CGPointMake(0, 0);
        CGVector impulse = CGVectorMake(0, 0);
        ball.physicsBody.velocity = impulse;
        int num = [high_score.text integerValue];
        if(counter > num){
            high_score.text = [NSString stringWithFormat:@"high score: %d", counter];
        }
        counter = 0.0;
        timer.text = @"0";
        [time invalidate];
        time = nil;
        playerPaddle.position = CGPointMake(0, 530);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerLostNotification" object:self];
    }
}

@end
