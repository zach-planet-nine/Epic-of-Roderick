//
//  HolgethAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HolgethAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"

@implementation HolgethAllEnemies

- (void)dealloc {
    
    if (bladeEmitter) {
        [bladeEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
       
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        bladeEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BladeEmitter.pex"];
        bladeEmitter.sourcePosition = Vector2fMake(valk.renderPoint.x + 20, valk.renderPoint.y + 8);
        enemies = [[NSMutableArray alloc] init];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                [enemies addObject:enemy];
            }
        }
        maxBleeders = [valk calculateHolgethBleeders];
        cutIndex = 0;
        stage = 0;
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
                    duration = 0.1;
                    break;
                case 1:
                    stage = stage;
                    AbstractBattleEnemy *enemy = [enemies objectAtIndex:(int)(RANDOM_0_TO_1() * [enemies count])];
                    //NSLog(@"Is it bugging here?");
                    [enemy addBleeder];
                    [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                    bleeders[cutIndex] = [sharedGameController.currentScene.activeEntities indexOfObject:enemy];
                    cutIndex++;
                    duration = 0.1;
                    if (cutIndex == maxBleeders) {
                        stage = 2;
                        duration = 6;
                        cutIndex = 0;
                    }
                    break;
                case 2:
                    stage = stage;
                    AbstractBattleEnemy *nemy = [sharedGameController.currentScene.activeEntities objectAtIndex:bleeders[cutIndex]];
                    [nemy removeBleeder];
                    cutIndex++;
                    if (cutIndex == maxBleeders) {
                        stage = 3;
                        duration = 1;
                    }
                    break;
                case 3:
                    stage++;
                    active = NO;
                    //NSLog(@"Got to here. Any bleeders left?");
                    break;
                    
                default:
                    break;
            }
        }
        if (stage < 2) {
            [bladeEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [bladeEmitter renderParticles];
    }
}

@end
