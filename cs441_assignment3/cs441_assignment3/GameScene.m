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
    SKSpriteNode* playerPaddle;
    SKSpriteNode* computerPaddle;
    SKPhysicsBody* border;
    SKSpriteNode* background;
}

- (void)didMoveToView:(SKView *)view {
    background = [SKSpriteNode spriteNodeWithImageNamed:@"football"];
    background.zPosition = 1;
    background.size = self.frame.size;
    //background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addChild:background];
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10];
    ball.physicsBody.friction = 0;
    ball.physicsBody.restitution = 1;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.angularDamping = 0;
    ball.physicsBody.affectedByGravity = false;
    ball.name = @"theduke";
    ball.userInteractionEnabled = true;
    [self addChild:ball];
    CGVector impulse = CGVectorMake(10, 10);
    [ball.physicsBody applyImpulse: impulse];
    border = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
    border.friction = 0;
    border.restitution = 1;
    border.linearDamping = 0;
    border.angularDamping = 0;
    self.physicsBody = border;
}


- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode: self];
    SKSpriteNode* touchedNode = [self nodeAtPoint:positionInScene];
    if(touchedNode && [touchedNode.name isEqualToString:@"theduke"]){
        NSLOG("Touched");
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
