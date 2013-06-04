//
//  UruzAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "UruzAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation UruzAllEnemies

- (void)dealloc {
    
    if (bulls) {
        [bulls release];
    }
    if (dustEmitters) {
        [dustEmitters release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                float tempDamage = (float)[ranger calculateUruzDamageTo:enemy];
                tempDamage *= 0.6;
                damages[enemyIndex] = (int)tempDamage;
                enemyIndex++;
            }
        }
        bulls = [[NSMutableArray alloc] initWithCapacity:5];
        dustEmitters = [[NSMutableArray alloc] initWithCapacity:5];
        for (int i = 0; i < 5; i++) {
            Image *bull = [[Image alloc] initWithImageNamed:@"Bull.png" filter:GL_NEAREST];
            bull.renderPoint = CGPointMake(-60 + (RANDOM_MINUS_1_TO_1() * 30), 260 - (i * 40));
            [bulls addObject:bull];
            ParticleEmitter *dustEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"DustEmitter.pex"];
            dustEmitter.sourcePosition = Vector2fMake(bull.renderPoint.x, bull.renderPoint.y - 30);
            [dustEmitters addObject:dustEmitter];
            [bull release];
            [dustEmitter release];
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
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(0.3, 0.3, 0.3, 1)];
                                enemy.stoneAffinity -= 2;
                            }
                        }
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
        for (Image *bull in bulls) {
            bull.renderPoint = CGPointMake(bull.renderPoint.x + (aDelta * 540), bull.renderPoint.y);
        }
        for (ParticleEmitter *pe in dustEmitters) {
            pe.sourcePosition = Vector2fMake(pe.sourcePosition.x + (aDelta * 540), pe.sourcePosition.y);
            [pe updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active) {
        for (Image *bull in bulls) {
            [bull renderCenteredAtPoint:bull.renderPoint];
        }
        for (ParticleEmitter *pe in dustEmitters) {
            [pe renderParticles];
        }
    }
}

@end
