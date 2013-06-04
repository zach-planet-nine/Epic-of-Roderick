//
//  Bear.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Bear.h"
#import "GameController.h"
#import "BattleRanger.h"
#import "Image.h"

@implementation Bear

- (id)init
{
    self = [super init];
    if (self) {
        
        defaultImage = [[Image alloc] initWithImageNamed:@"Bear.png" filter:GL_LINEAR];
		agility = 4;
		essence = 20;
        ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    [super updateWithDelta:aDelta];
    if (velocity.x != 0 || velocity.y != 0) {
        Vector2f temp = Vector2fMultiply(velocity, aDelta);
        renderPoint = CGPointMake(renderPoint.x + temp.x, renderPoint.y + temp.y);
        if (fabsf(renderPoint.x - destination.x) < 5 && fabsf(renderPoint.y - destination.y) < 5) {
            renderPoint = destination;
            velocity = Vector2fMake(0, 0);
        }
    }
}

- (void)render {
    
    [defaultImage renderCenteredAtPoint:defaultImage.renderPoint];
}

- (void)beSummoned {
    
    defaultImage.renderPoint = CGPointMake(ranger.renderPoint.x, ranger.renderPoint.y - 30);
}

- (void)bearMoveToPoint:(CGPoint)aPoint {
    destination = aPoint;
    velocity = Vector2fMake((aPoint.x - renderPoint.x) * 0.5, (aPoint.y - renderPoint.y) * 0.5);
}

- (void)bearMoveBackToRanger {
    destination = CGPointMake(ranger.renderPoint.x, ranger.renderPoint.y - 30);
    velocity = Vector2fMake((destination.x - renderPoint.x) * 0.5, (destination.y - renderPoint.y) * 0.5);
}

@end
