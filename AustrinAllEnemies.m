//
//  AustrinAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AustrinAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"
#import "WorldFlashColor.h"
#import "FadeInOrOut.h"

@implementation AustrinAllEnemies

- (void)dealloc {
    
    if (rainEmitter) {
        [rainEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        int damageIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damage[damageIndex] = [roderick calculateAustrinDamageTo:enemy];
                damageIndex++;
                enemy.skyAffinity -= (1 + ((roderick.level + roderick.levelModifier + roderick.skyAffinity - enemy.skyAffinity) / 10));
                enemy.skyAffinity = MAX(1, enemy.skyAffinity);
            }
        }
        rainEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"RainEmitter.pex"];
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1];
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
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    duration = 0.8;
                    WorldFlashColor *wfc = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(0.9, 0.9, 0, 0.3)];
                    [sharedGameController.currentScene addObjectToActiveObjects:wfc];
                    [wfc release];
                    break;
                case 2:
                    stage++;
                    duration = 0.3;
                    WorldFlashColor *wfc2 = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(0.9, 0.9, 0, 0.3)];
                    [sharedGameController.currentScene addObjectToActiveObjects:wfc2];
                    [wfc2 release];
                    break;
                case 3:
                    stage++;
                    duration = 1;
                    int damageIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damage[damageIndex]];
                            damageIndex++;
                        }
                    }
                    break;
                case 4:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [dimWorld updateWithDelta:aDelta];
                break;
            case 1:
                [rainEmitter updateWithDelta:aDelta];
                break;
            case 2:
                [rainEmitter updateWithDelta:aDelta];
                break;
            case 3:
                [rainEmitter updateWithDelta:aDelta];
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 4) {
        [dimWorld render];
        [rainEmitter renderParticles];
    }
}

@end
