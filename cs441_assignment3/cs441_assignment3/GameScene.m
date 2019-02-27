//
//  GameScene.m
//  cs441_assignment3
//
//  Created by Kevin Wu on 2/17/19.
//  Copyright © 2019 Kevin Wu. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    
    SKSpriteNode* ball;
    SKNode* playerPaddle;
    SKPhysicsBody* border;
    SKSpriteNode* background;
    Boolean paddleTouched;
    
}

- (void)didMoveToView:(SKView *)view {
    paddleTouched = false;
    background = [SKSpriteNode spriteNodeWithImageNamed:@"court.jpg"];
    background.size = self.frame.size;
    background.zPosition = -1;
    //background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addChild:background];
    playerPaddle = [self childNodeWithName:(@"paddle")];
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode: self];
    SKNode* touchedNode = [self nodeAtPoint:positionInScene];
    if([touchedNode.name isEqualToString:@"theduke"]){
        CGVector impulse = CGVectorMake(5, 5);
        [touchedNode.physicsBody applyImpulse: impulse];
    }
    if([touchedNode.name isEqualToString:@"paddle"]){
        paddleTouched = true;
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(paddleTouched){
        UITouch* touch = [touches anyObject];
        CGPoint positionInScene = [touch locationInNode: self];
        playerPaddle.position = positionInScene;
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
}

@end
