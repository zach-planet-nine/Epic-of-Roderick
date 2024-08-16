//
//  HawkAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "HawkAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"
#import "Hawk.h"

@implementation HawkAllEnemies 

- (void)dealloc {
    [super dealloc];
}

- (id)initFromHawk:(Hawk *)aHawk {
    
    self = [super init];
    if (self) {
        
        hawkEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"HawkEmitter.pex"];
        hawkEmitter.sourcePosition = Vector2fMake(240, 240);
        hawk = aHawk;
        velocity = Vector2fMake((220 - hawk.renderPoint.x) * 2, (240 - hawk.renderPoint.y) * 2);
        stage = 0;
        duration = 0.5;
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
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy flashColor:Color4fMake(0.4, 0, 0.4, 1)];
                            [enemy youTookDamage:[hawk calculateHawkDamage]];
                        }
                    }
                    velocity = Vector2fMake(velocity.x * -1, velocity.y * -1);
                    duration = 0.5;
                    break;
                case 2:
                    stage++;
                    [hawk flyBackToRanger];
                    duration = 0.5;
                    break;
                case 3:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                stage = stage;
                Vector2f temp = Vector2fMultiply(velocity, aDelta);
                hawk.renderPoint = CGPointMake(hawk.renderPoint.x + temp.x, hawk.renderPoint.y + temp.y);
                break;
            case 1:
                [hawkEmitter updateWithDelta:aDelta];
                break;
            case 2:
                [hawkEmitter updateWithDelta:aDelta];
                Vector2f temp2 = Vector2fMultiply(velocity, aDelta);
                hawk.renderPoint = CGPointMake(hawk.renderPoint.x + temp2.x, hawk.renderPoint.y + temp2.y);
                break;
            
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        if (stage == 1 || stage == 2) {
            [hawkEmitter renderParticles];
        }
    }
}

@end
