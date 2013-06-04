//
//  FehuSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FehuSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Image.h"

@implementation FehuSingleEnemy

- (void)dealloc {
    
    if (bush) {
        [bush release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        fehuDuration = [ranger calculateFehuDurationTo:aEnemy];
        target1 = aEnemy;
        bush = [[Image alloc] initWithImageNamed:@"Bush.png" filter:GL_NEAREST];
        bush.renderPoint = CGPointMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y - 20);
        stage = 0;
        duration = 1;
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
                    target1.endurance = -1000;
                    duration = fehuDuration;
                    break;
                case 1:
                    stage++;
                    target1.endurance = target1.maxEndurance;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            bush.scale = Scale2fMake(bush.scale.x, bush.scale.y + aDelta);
            bush.renderPoint = CGPointMake(bush.renderPoint.x, bush.renderPoint.y + aDelta);
        }
    }
}

- (void)render {
    
    if (active) {
        [bush renderCenteredAtPoint:bush.renderPoint];
    }
}

@end
