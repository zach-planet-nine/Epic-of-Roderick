//
//  BerkanoAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BerkanoAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Animation.h"
#import "BattleStringAnimation.h"

@implementation BerkanoAllEnemies

- (void)dealloc {
    
    if (enemies) {
        [enemies release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        enemies = [[NSMutableArray alloc] init];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                if ((valk.affinity + valk.affinityModifier + valk.deathAffinity) * (valk.essence / valk.maxEssence) > enemy.affinity + enemy.affinityModifier + enemy.deathAffinity) {
                    [enemies addObject:enemy];
                } else {
                    BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:enemy.renderPoint];
                    [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
                    [ineffective release]; 
                }
            }
        }
        if ([enemies count] > 0) {
            stage = 0;
            duration = 1.5;
            active = YES;
        } else {
            
            stage = 5;
            active = NO;
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
                    for (AbstractBattleEnemy *enemy in enemies) {
                        [enemy youWereBerkanoed];
                    }
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
    }
}

@end
