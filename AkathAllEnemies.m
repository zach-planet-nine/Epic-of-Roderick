//
//  AkathAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AkathAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Image.h"

@implementation AkathAllEnemies

- (void)dealloc {
    
    if (clock) {
        [clock release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
       
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                [enemy addToStatusDurations:([valk calculateAkathAdderTo:enemy] * 0.7)];
            }
        }
        clock = [[Image alloc] initWithImageNamed:@"Clock.png" filter:GL_LINEAR];
        clock.color = Color4fMake(1, 1, 1, 0);
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
                    break;
                    
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
                    clock.color = Color4fOnes;
                } else {
                    clock.color = Color4fMake(1, 1, 1, 0);
                }
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                [clock renderCenteredAtPoint:CGPointMake(enemy.renderPoint.x, enemy.renderPoint.y + 15)];
            }
        }
    }
}

@end
