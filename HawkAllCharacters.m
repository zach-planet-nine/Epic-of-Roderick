//
//  HawkAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "HawkAllCharacters.h"
#import "Hawk.h"

@implementation HawkAllCharacters 

- (void)dealloc {
    [super dealloc];
}

- (id)initFromHawk:(Hawk *)aHawk {
    
    self = [super init];
    if (self) {
        stage = 0;
        duration = 0.05;
        active = YES;
        defensePoint = CGPointMake(180, 160);
        hawk = aHawk;
        if (hawk.renderPoint.x != 180) {
            duration = 0.5;
            velocity = Vector2fMake((180 - hawk.renderPoint.x) * 2, (160 - hawk.renderPoint.y) * 2);
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
                    duration = 0.5;
                    hawk.renderPoint = defensePoint;
                    hawk.defenseMode = YES;
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
            Vector2f temp = Vector2fMake(velocity.x * aDelta, velocity.y * aDelta);
            hawk.renderPoint = CGPointMake(hawk.renderPoint.x + temp.x, hawk.renderPoint.y + temp.y);
        }
    }
}

@end
