//
//  VestrinAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "VestrinAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "Textbox.h"

@implementation VestrinAllEnemies

- (void)dealloc {
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damage[enemyIndex] = [roderick calculateVestrinDamageTo:enemy];
                disorientationRolls[enemyIndex] = [roderick calculateVestrinRollTo:enemy];
                enemyIndex++;
            }
        }
        //Remove this and replace with real animation
        tb = [[Textbox alloc] initWithRect:CGRectMake(120, 120, 120, 40) color:Color4fMake(0.3, 0.3, 0.3, 0.8) duration:2 animating:NO text:@"TORNADOED!"];
        stage = 0;
        duration = 2;
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
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damage[enemyIndex]];
                            [enemy youWereDisoriented:(int)(disorientationRolls[enemyIndex])];
                            enemyIndex++;
                        }
                    }
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [tb updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [tb render];
    }
}

@end
