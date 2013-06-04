//
//  EnemyFatigueCure.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyFatigueCure.h"
#import "AbstractBattleEnemy.h"
#import "Image.h"
#import "BattleStringAnimation.h"

@implementation EnemyFatigueCure

- (void)dealloc {
    
    if (trumpet) {
        [trumpet release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        target1 = aEnemy;
        trumpet = [[Image alloc] initWithImageNamed:@"Trumpet.png" filter:GL_NEAREST];
        trumpet.renderPoint = CGPointMake(aEnemy.renderPoint.x - 30, aEnemy.renderPoint.y + 20);
        trumpet.scale = Scale2fMake(0.5, 0.5);
        stage = 10;
        duration = 0.3;
        active = YES;
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    [target1 flashColor:Blue];
                    target1.isFatigued = NO;
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                case 10:
                    stage = 0;
                    duration = 0.5;
                    break;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            trumpet.scale = Scale2fMake(trumpet.scale.x + aDelta, trumpet.scale.y + aDelta);
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [trumpet renderCenteredAtPoint:trumpet.renderPoint];
    }
}

@end
