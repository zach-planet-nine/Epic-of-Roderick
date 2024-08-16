//
//  FirstArrowShot.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FirstArrowShot.h"
#import "Projectile.h"
#import "ParticleEmitter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "AbstractBattleCharacter.h"
#import "PackedSpriteSheet.h"
#import "BitmapFont.h"
#import "AbstractBattleAnimalEntity.h"
#import "Hawk.h"
#import "HawkCatchArrow.h"


@implementation FirstArrowShot

- (void)dealloc {
	
	if (arrow) {
		[arrow release];
	}
	if (bleeder) {
		[bleeder release];
	}
	
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
		
	if (self = [super init]) {
		
		active = YES;
		stage = 0;
		ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        damage = [ranger calculateAttackDamageTo:aEnemy];
		destination = [ranger getTargetPoint];
		//NSLog(@"Destination is: (%f, %f).", destination.x, destination.y);
		float angle = atanf((aEnemy.renderPoint.y - ranger.renderPoint.y) / (aEnemy.renderPoint.x - ranger.renderPoint.x)) * 57.2957795;
		if (angle < 0 && aEnemy.renderPoint.x - ranger.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && aEnemy.renderPoint.y - ranger.renderPoint.y < 0) {
			angle += 360;
		} else if (aEnemy.renderPoint.x - ranger.renderPoint.x < 0 && aEnemy.renderPoint.y - ranger.renderPoint.y < 0) {
			angle += 180;
		}
		arrow = [[Projectile alloc] initProjectileFrom:Vector2fMake(ranger.renderPoint.x, ranger.renderPoint.y + 40) 
													to:Vector2fMake(destination.x, destination.y) 
							  withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] 
											   lasting:0.3 withStartAngle:angle 
										 withStartSize:Scale2fMake(0.5, 0.5) 
										  toFinishSize:Scale2fMake(0.5, 0.5)];
		bleeder = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodSplatter.pex"];
		bleeder.sourcePosition = Vector2fMake(destination.x, destination.y);
		//NSLog(@"blood splatters source position is: (%f, %f).", bleeder.sourcePosition.x, bleeder.sourcePosition.y);
		bleeder.duration = 0.3;
		bleeder.active = NO;
		target1 = aEnemy;
		duration = 0.3;
		bleeds = 4;
	}
	
	return self;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime {
    
    if (self = [super init]) {
        self = [self initToEnemy:aEnemy];
        stage = 10;
        duration = aWaitTime;
    }
    return self;
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter {
    self = [super init];
    if (self) {
        
        destination = aCharacter.renderPoint;
		float angle = atanf((aCharacter.renderPoint.y - aEnemy.renderPoint.y) / (aCharacter.renderPoint.x - aEnemy.renderPoint.x)) * 57.2957795;
		if (angle < 0 && aCharacter.renderPoint.x - aEnemy.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && aCharacter.renderPoint.y - aEnemy.renderPoint.y < 0) {
			angle += 360;
		} else if (aCharacter.renderPoint.x - aEnemy.renderPoint.x < 0 && aEnemy.renderPoint.y - ranger.renderPoint.y < 0) {
			angle += 180;
		}
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isMemberOfClass:[BattleRanger class]]) {
                BattleRanger *ranger = character;
                if ([ranger isHawkInDefenseMode]) {
                    arrow = [[Projectile alloc] initProjectileFrom:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 40) 
                                                                to:Vector2fMake(destination.x * 0.5, destination.y * 0.5) 
                                          withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] 
                                                           lasting:0.15 withStartAngle:angle 
                                                     withStartSize:Scale2fMake(0.5, 0.5) 
                                                      toFinishSize:Scale2fMake(0.5, 0.5)];
                    [HawkCatchArrow hawk:ranger.currentAnimal CatchArrowAt:CGPointMake(destination.x * 0.5, destination.y * 0.5)];
                    stage = 100;
                    duration = 0.15;
                    active = YES;
                    return self;
                }
            }

        }
                
        damage = [aEnemy calculateArrowDamageToCharacter:aCharacter];
		arrow = [[Projectile alloc] initProjectileFrom:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 40) 
													to:Vector2fMake(destination.x, destination.y) 
							  withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] 
											   lasting:0.3 withStartAngle:angle 
										 withStartSize:Scale2fMake(0.5, 0.5) 
										  toFinishSize:Scale2fMake(0.5, 0.5)];
		bleeder = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodSplatter.pex"];
		bleeder.sourcePosition = Vector2fMake(destination.x, destination.y);
		//NSLog(@"blood splatters source position is: (%f, %f).", bleeder.sourcePosition.x, bleeder.sourcePosition.y);
		bleeder.duration = 0.3;
		bleeder.active = NO;
		target1 = aCharacter;
        bleeds = 4;
        stage = 10;
		duration = 0.3;
        active = YES;
    }
    return self;
}

- (void)updateWithDelta:(float)aDelta {
	
    if (active) {
        duration -= aDelta;
        if (duration < 0.0) {
            switch (stage) {
                case 0:
                    stage = 1;
                    bleeder.active = YES;
                    [target1 addBleeder];
                    [target1 youTookDamage:damage];
                    duration = 3.0;
                    break;
                case 1:
                    arrow.elapsedTime = 0;
                    bleeds--;
                    duration = 3.0;
                    bleeder.active = YES;
                    if (bleeds == 0 && target1) {
                        [target1 removeBleeder];
                        stage = 2;
                        active = NO;
                    }
                    break;
                case 10:
                    stage = 0;
                    duration = 0.3;
                    break;
                case 100:
                    stage++;
                    duration = 0.5;
                    break;
                case 101:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
	
		switch (stage) {
			case 0:
				[arrow updateWithDelta:aDelta];
				break;
			case 1:
				[bleeder updateWithDelta:aDelta];
				break;
            case 100:
                [arrow updateWithDelta:aDelta];
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
				[arrow render];
				break;
			case 1:
                if (target1.isAlive) {
                    [arrow render];
                    [bleeder renderParticles];
                }
				break;
            case 100:
                [arrow render];
                break;
				
			default:
				break;
		}
	}
}

@end
