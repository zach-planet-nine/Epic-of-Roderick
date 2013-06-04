//
//  MannazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MannazSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractEntity.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "NPCEnemyAxeMan.h"
#import "NPCEnemySwordMan.h"
#import "WorldFlashColor.h"

@implementation MannazSingleEnemy

- (void)dealloc {
    
    if (soldiers) {
        [soldiers release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        soldiers = [[NSMutableArray alloc] init];
        target1 = aEnemy;
        int soldierCount = [wizard calculateMannazSoldierCountTo:aEnemy];
        int soldierIndex = 0;
        while (soldierIndex < soldierCount) {
            if (RANDOM_0_TO_1() < 0.5) {
                NPCEnemyAxeMan *axeMan = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(240 - (RANDOM_0_TO_1() * 40), RANDOM_0_TO_1() * 320)];
                [axeMan fadeIn];
                [soldiers addObject:axeMan];
                [axeMan release];
            } else {
                NPCEnemySwordMan *swordMan = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(240 - (RANDOM_0_TO_1() * 40), RANDOM_0_TO_1() * 320)];
                [swordMan fadeIn];
                [soldiers addObject:swordMan];
                [swordMan release];
            }
            soldierIndex++;
        }
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
                    WorldFlashColor *wfc = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(1, 0, 0, 0.4)];
                    [sharedGameController.currentScene addObjectToActiveObjects:wfc];
                    [wfc release];
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    for (AbstractEntity *entity in soldiers) {
                        [entity moveToPoint:CGPointMake(target1.renderPoint.x + 40, target1.renderPoint.y) duration:1];
                        [entity fadeOut];
                    }
                    duration = 0.8;
                    break;
                case 2:
                    stage++;
                    [target1 flashColor:Color4fMake(1, 0, 0, 1)];
                    int damageIndex = 0;
                    while (damageIndex < [soldiers count]) {
                        [target1 youTookDamage:(int)((RANDOM_0_TO_1() * 50) + 10)];
                        damageIndex++;
                    }
                    duration = 1;
                    break;
                case 3:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        for (AbstractEntity *entity in soldiers) {
            [entity updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active) {
        for (AbstractEntity *entity in soldiers) {
            [entity render];
        }
    }
}

@end
