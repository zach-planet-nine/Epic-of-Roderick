//
//  HawkSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "HawkSingleCharacter.h"
#import "AbstractBattleEntity.h"
#import "Hawk.h"

@implementation HawkSingleCharacter 

- (void)dealloc {
    [super dealloc];
}

- (id)initToEntity:(AbstractBattleEntity *)aEntity fromHawk:(Hawk *)aHawk {
    
    self = [super init];
    if (self) {
        target1 = aEntity;
        hawk = aHawk;
        velocity = Vector2fMake(0, 0);
        stage = 0;
        duration = 0.05;
        active = YES;
        if (hawk.renderPoint.y != aEntity.renderPoint.y + 35) {
            velocity = Vector2fMake((target1.renderPoint.x - hawk.renderPoint.x) * 2, (target1.renderPoint.y + 35 - hawk.renderPoint.y) * 2);
            stage = 0;
            duration = 0.5;
            active = YES;
        }
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
                    [target1 youWereMotivated:(int)[hawk calculateMotivationDurationTo:target1]];
                    hawk.renderPoint = CGPointMake(target1.renderPoint.x, target1.renderPoint.y + 35);
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            Vector2f temp = Vector2fMultiply(velocity, aDelta);
            hawk.renderPoint = CGPointMake(hawk.renderPoint.x + temp.x, hawk.renderPoint.y + temp.y);
        }
    }
}

@end
