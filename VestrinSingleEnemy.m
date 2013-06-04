//
//  VestrinSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "VestrinSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleEntity.h"
#import "BattleRoderick.h"
#import "Image.h"
#import "PackedSpriteSheet.h"
#import "Projectile.h"

@implementation VestrinSingleEnemy

- (void)dealloc {
    
    if (debris) {
        [debris release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy 
{
    self = [super init];
    if (self) {
        
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        debris = [[NSMutableArray alloc] init];
        target1 = aEnemy;
        float possibleDebris = ((roderick.power + roderick.powerModifier + roderick.skyAffinity) * (roderick.essence / roderick.maxEssence)) / 10;
        //NSLog(@"Possible Debris is: %f", possibleDebris);

        bleederDuration = [roderick calculateVestrinDurationTo:aEnemy];
        possibleDebris = (arc4random() % (int)(possibleDebris + 1)) + 1;
        //NSLog(@"Possible Debris is: %f", possibleDebris);
        for (int i = 0; i < possibleDebris; i++) {
            CGPoint fromPoint = CGPointMake(0 - (RANDOM_0_TO_1() * 100), 160 + (RANDOM_MINUS_1_TO_1() * 200));
            Vector2f vector = Vector2fMake(aEnemy.renderPoint.x - fromPoint.x, aEnemy.renderPoint.y - fromPoint.y);
            if (vector.x == 0) {
                vector.x = 1;
            }
            if (vector.y == 0) {
                vector.y = 1;
            }
            float angle = atanf((vector.y / vector.x)) * 57.2957795;
            if (angle < 0 && vector.x < 0) {
                angle += 180;
            } else if (angle < 0 && vector.y < 0) {
                angle += 360;
            } else if (vector.x < 0 && vector.y < 0) {
                angle += 180;
            }

            float whichDebris = arc4random() % 100;
            //NSLog(@"whichDebris: %f", whichDebris);
            if (whichDebris < 20) {
                Projectile *frogProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(fromPoint.x, fromPoint.y) to:Vector2fMake((aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2)) withSSImage:[[[sharedGameController.teorPSS imageForKey:@"Frog40x40.png"] imageDuplicate] retain] lasting:(0.5 + RANDOM_0_TO_1()) withStartAngle:angle withStartSize:Scale2fMake(0.5, 0.5) toFinishSize:Scale2fMake(0.5, 0.5) revolving:NO];
                [debris addObject:frogProjectile];
                //NSLog(@"frog from (%f,%f) to (%f, %f).", fromPoint.x, fromPoint.y, (aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2));
            } else if (41 > whichDebris && whichDebris >= 20) {
                Projectile *chestProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(fromPoint.x, fromPoint.y) to:Vector2fMake((aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2)) withSSImage:[[[sharedGameController.teorPSS imageForKey:@"ChestClosed.png"] imageDuplicate] retain] lasting:(0.5 + RANDOM_0_TO_1()) withStartAngle:angle withStartSize:Scale2fMake(0.5, 0.5) toFinishSize:Scale2fMake(0.5, 0.5) revolving:NO];
                [debris addObject:chestProjectile];
                 //NSLog(@"chest from (%f,%f) to (%f, %f).", fromPoint.x, fromPoint.y, (aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2));
            } else if (61 > whichDebris && whichDebris >= 41) {
                Projectile *orcProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(fromPoint.x, fromPoint.y) to:Vector2fMake((aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2)) withSSImage:[[[sharedGameController.teorPSS imageForKey:@"Orc120x120.png"] imageDuplicate] retain] lasting:(0.5 + RANDOM_0_TO_1()) withStartAngle:angle withStartSize:Scale2fMake(0.27, 0.27) toFinishSize:Scale2fMake(0.27, 0.27) revolving:NO];
                [debris addObject:orcProjectile];
                 //NSLog(@"orc from (%f,%f) to (%f, %f).", fromPoint.x, fromPoint.y, (aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2));
            } else if (81 > whichDebris && whichDebris >= 61) {
                Projectile *antidoteProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(fromPoint.x, fromPoint.y) to:Vector2fMake((aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2)) withSSImage:[[[sharedGameController.teorPSS imageForKey:@"Antidote30x30.png"] imageDuplicate] retain] lasting:(0.5 + RANDOM_0_TO_1()) withStartAngle:angle withStartSize:Scale2fMake(0.6, 0.6) toFinishSize:Scale2fMake(0.6, 0.6) revolving:NO];
                [debris addObject:antidoteProjectile];
                 //NSLog(@"antidote from (%f,%f) to (%f, %f).", fromPoint.x, fromPoint.y, (aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2));
            }
        }
        stage = 0;
        active = YES;
        duration = 2;
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
                    duration = bleederDuration;
                    break;
                case 1:
                    stage++;
                    for (int i = 0; i < 10; i++) {
                        if (hasDamaged[i]) {
                            [target1 removeBleeder];
                        }
                    }
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                for (Projectile *pro in debris) {
                    [pro updateWithDelta:aDelta];
                    if (pro.currentPoint.x > target1.renderPoint.x && !hasDamaged[[debris indexOfObject:pro]]) {
                        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
                        [target1 youTookDamage:(int)((roderick.skyAffinity - target1.skyAffinity) * 3)];
                        [target1 addBleeder];
                        hasDamaged[[debris indexOfObject:pro]] = YES;
                    }
                }
                
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        for (Projectile *pro in debris) {
            [pro renderProjectiles];
        }
    }
}

@end
