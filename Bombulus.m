//
//  Bombulus.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "Bombulus.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "Projectile.h"
#import "BattleDwarf.h"
#import "ParticleEmitter.h"


@implementation Bombulus

- (void)dealloc {
    if (bomb) {
        [bomb release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
    self = [super init];
    if (self) {
        
        dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
        target1 = aEnemy;
        bomb = [[Projectile alloc] initProjectileFrom:Vector2fMake(dwarf.renderPoint.x + 20, dwarf.renderPoint.y) to:Vector2fMake(target1.renderPoint.x, target1.renderPoint.y - 30) withImage:@"Bombulus.png" lasting:1.5 withStartAngle:45 withStartSize:Scale2fMake(0.3, 0.3) toFinishSize:Scale2fMake(1, 1)];
        explosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Explosion.pex"];
        explosion.sourcePosition = Vector2fMake(target1.renderPoint.x, target1.renderPoint.y - 30);
        explosion.startColor = Red;
        stage = 0;
        duration = 1.5;
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
                    [target1 youTookDamage:[dwarf calculateBombulusDamageTo:target1]];
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    duration = 0.5;
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
                [bomb updateWithDelta:aDelta];
                break;
            case 1:
                [explosion updateWithDelta:aDelta];
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
                [bomb renderProjectiles];
                break;
            case 1:
                [explosion renderParticles];
                break;
            default:
                break;
        }
    }
}

@end
