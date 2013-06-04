//
//  JeraSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "JeraSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation JeraSingleEnemy

- (void)dealloc {
    
    if (norn) {
        [norn release];
    }
    if (rageExplosion) {
        [rageExplosion release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        target1 = aEnemy;
        norn = [[Image alloc] initWithImageNamed:@"Norn.png" filter:GL_LINEAR];
        norn.color = Color4fMake(1, 1, 1, 0);
        norn.renderPoint = CGPointMake(aEnemy.renderPoint.x - 50, aEnemy.renderPoint.y);
        float tempDamage = MAX(9999, aEnemy.damageDealt);
        tempDamage *= (valk.rageAffinity / aEnemy.rageAffinity);
        tempDamage *= (valk.essence / valk.maxEssence);
        tempDamage = MAX(0, tempDamage);
        damage = (int)tempDamage;
        rageExplosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"WizardBallExplosion.pex"];
        rageExplosion.startColor = valk.essenceColor;
        rageExplosion.finishColor = Color4fMake(valk.essenceColor.red, valk.essenceColor.green, valk.essenceColor.blue, 0);
        rageExplosion.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y);
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
                    duration = 1;
                    [target1 flashColor:Color4fMake(0.4, 0.4, 0, 1)];
                    [target1 youTookDamage:damage];
                    break;
                case 1:
                    stage++;
                    duration = 1;
                    break;
                case 2:
                    stage++;
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
        switch (stage) {
            case 0:
                norn.color = Color4fMake(1, 1, 1, norn.color.alpha + aDelta);
                break;
            case 1:
                [rageExplosion updateWithDelta:aDelta];
                break;
            case 2:
                [rageExplosion updateWithDelta:aDelta];
                norn.color = Color4fMake(1, 1, 1, norn.color.alpha - aDelta);
                break;
            case 3:
                [rageExplosion updateWithDelta:aDelta];
                break;

                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        switch (stage) {
            case 0:
                [norn renderCenteredAtPoint:norn.renderPoint];
                break;
            case 1:
                [norn renderCenteredAtPoint:norn.renderPoint];
                [rageExplosion renderParticles];
                break;
            case 2:
                [norn renderCenteredAtPoint:norn.renderPoint];
                [rageExplosion renderParticles];
                break;
            case 3:
                [rageExplosion renderParticles];
                break;
            default:
                break;
        }
    }
}

@end
