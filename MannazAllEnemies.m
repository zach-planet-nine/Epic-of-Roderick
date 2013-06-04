//
//  MannazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MannazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "WorldFlashColor.h"
#import "NPCEnemyAxeMan.h"
#import "NPCEnemySwordMan.h"

@implementation MannazAllEnemies

- (void)dealloc {
    
    if (soldiers) {
        [soldiers release];
    }
    if (enemies) {
        [enemies release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        soldiers = [[NSMutableArray alloc] init];
        enemies = [[NSMutableArray alloc] init];
        for (AbstractBattleEnemy *aEnemy in sharedGameController.currentScene.activeEntities) {
            if ([aEnemy isKindOfClass:[AbstractBattleEnemy class]] && aEnemy.isAlive) {
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
                    [enemies addObject:aEnemy];
                    soldierIndex++;
                }

            }
            
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
                        [entity moveToPoint:CGPointMake(480, entity.currentLocation.y) duration:1];
                        [entity fadeOut];
                    }
                    duration = 0.8;
                    break;
                case 2:
                    stage++;
                    int soldierIndex = 0;
                    while (soldierIndex < [soldiers count]) {
                        AbstractBattleEnemy *enemy = [enemies objectAtIndex:(int)(RANDOM_0_TO_1() * [enemies count])];
                        [enemy youTookDamage:(int)((RANDOM_0_TO_1() * 40) + 10)];
                        [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                        soldierIndex++;
                    }
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
