//
//  PrimazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PrimazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Valkyrie.h"
#import "Projectile.h"
#import "PackedSpriteSheet.h"
#import "ParticleEmitter.h"


@implementation PrimazSingleEnemy

- (void)dealloc {
    
    if (valkyries) {
        [valkyries release];
    }
    if (spears) {
        [spears release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy 
{
    self = [super init];
    if (self) {
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        valkyries = [[NSMutableArray alloc] init];
        spears = [[NSMutableArray alloc] init];
        target1 = aEnemy;
        //NSLog(@"%d", (int)(((aEnemy.rageAffinity / 10) * (valk.essence / valk.maxEssence)) + 1));
        //NSLog(@"%f, %f, %f", aEnemy.rageAffinity, valk.essence, valk.maxEssence);
        for (int i = 0; i < (int)(((aEnemy.rageAffinity / 10) * (valk.essence / valk.maxEssence)) + 1); i++) {
            Valkyrie *valkyrie = [[Valkyrie alloc] initAtLocation:CGPointMake(160 - (RANDOM_0_TO_1() * 320), 360 + (RANDOM_0_TO_1() * 100))];
            [valkyrie moveToPoint:CGPointMake(120 + (RANDOM_0_TO_1() * 60), RANDOM_0_TO_1() * 360) duration:0.9];
            [valkyries addObject:valkyrie];
        }
        primazDuration = [valk calculatePrimazDurationTo:aEnemy];
        bloodBurst = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodBurst.pex"];
        bloodBurst.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y);
		bloodBurst.duration = 0.3;
        stage = 0;
        duration = 1.2;
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
                    for (Valkyrie *valkyrie in valkyries) {
                        Projectile *spear = [[Projectile alloc] initProjectileFrom:Vector2fMake(valkyrie.currentLocation.x, valkyrie.currentLocation.y + 20) to:Vector2fMake(target1.renderPoint.x, target1.renderPoint.y) withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] lasting:0.25 withStartAngle:0 withStartSize:Scale2fMake(0.7, 0.7) toFinishSize:Scale2fMake(0.7, 0.7)];
                        [spears addObject:spear];
                        [valkyrie faceRight];
                    }
                    duration = 0.24;
                    break;
                case 1:
                    stage++;
                    for (Valkyrie *valkyrie in valkyries) {
                        [valkyrie fadeOut];
                        [target1 youTookDamage:(int)(target1.rageAffinity + (RANDOM_0_TO_1() * 20))];
                        [target1 addBleeder];
                    }
                    duration = 0.3;
                    break;
                case 2:
                    stage++;
                    duration = primazDuration - 0.3;
                    break;
                case 3:
                    stage++;
                    for (Valkyrie *valkyrie in valkyries) {
                        [target1 removeBleeder];
                    }
                    duration = 1;
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
                for (Valkyrie *valkyrie in valkyries) {
                    [valkyrie updateWithDelta:aDelta];
                }
                break;
            case 1:
                for (Projectile *spear in spears) {
                    [spear updateWithDelta:aDelta];
                }
            case 2:
                [bloodBurst updateWithDelta:aDelta];
                for (Valkyrie *valkyrie in valkyries) {
                    [valkyrie updateWithDelta:aDelta];
                }
                break;
            case 3:
                for (Valkyrie *valkyrie in valkyries) {
                    [valkyrie updateWithDelta:aDelta];
                }
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
                for (Valkyrie *valkyrie in valkyries) {
                    [valkyrie render];
                }
                break;
            case 1:
                for (Projectile *spear in spears) {
                    [spear renderProjectiles];
                }
            case 2:
                [bloodBurst renderParticles];
                for (Valkyrie *valkyrie in valkyries) {
                    [valkyrie render];
                }
                break;
            case 3:
                for (Valkyrie *valkyrie in valkyries) {
                    [valkyrie render];
                }
                break;
            default:
                break;
        }

    }
}

@end
