//
//  HelazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HelazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation HelazAllEnemies

- (void)dealloc {
    
    if (garm) {
        [garm release];
    }
    if (helazEmitter) {
        [helazEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                float tempDamage = (float)[poet calculateHelazDamageTo:enemy];
                tempDamage *= 0.7;
                enemy.divineAffinity -= 2;
                damages[enemyIndex] = (int)tempDamage;
                enemyIndex++;
            }
        }
        garm = [[Image alloc] initWithImageNamed:@"Garm.png" filter:GL_NEAREST];
        garm.renderPoint = CGPointMake(240, 160);
        garm.color = Color4fMake(0, 0, 0, 1);
        helazEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"HelazEmitterBig.pex"];
        helazEmitter.sourcePosition = Vector2fMake(360, 160);
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
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                            }
                        }
                    }
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
                garm.color = Color4fMake(garm.color.red + aDelta, garm.color.green + aDelta, garm.color.blue + aDelta, 1);
                break;
            case 1:
                [helazEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [garm renderCenteredAtPoint:garm.renderPoint];
        if (stage == 1) {
            [helazEmitter renderParticles];
        }
    }
}

@end
