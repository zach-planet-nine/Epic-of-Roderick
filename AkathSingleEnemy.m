//
//  AkathSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AkathSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Image.h"

@implementation AkathSingleEnemy

- (void)dealloc {
    
    if (clock) {
        [clock release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy 
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        clock = [[Image alloc] initWithImageNamed:@"Clock.png" filter:GL_NEAREST];
        clock.renderPoint = CGPointMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 15);
        clock.color = Color4fMake(1, 1, 1, 0);
        akathAdder = [valk calculateAkathAdderTo:aEnemy];
        [aEnemy addToStatusDurations:akathAdder];
        target1 = aEnemy;
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
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                clock.color = Color4fMake(1, 1, 1, clock.color.alpha + aDelta);
                break;
            case 1:
                if (clock.color.alpha == 0) {
                    clock.color = Color4fMake(1, 1, 1, 1);
                } else {
                    clock.color = Color4fMake(1, 1, 1, 0);
                }
                break;
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [clock renderCenteredAtPoint:clock.renderPoint];
    }
}

@end
