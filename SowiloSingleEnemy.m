//
//  SowiloSingleEnemy.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SowiloSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"
#import "Image.h"
#import "BattleStringAnimation.h"


@implementation SowiloSingleEnemy

- (void)dealloc {
	
	if (sun) {
		[sun release];
	}
	if (rayOfLight) {
		[rayOfLight release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		target1 = aEnemy;
		valkyrie = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
		sun = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"Sun.pex" fromPoint:CGPointMake(100, 290) toPoint:CGPointMake(100, 290)];
		rayOfLight = [[Image alloc] initWithImageNamed:@"RayOfLight.png" filter:GL_NEAREST];
		rayOfLight.renderPoint = CGPointMake(120, 270);
		float angle = atanf((aEnemy.renderPoint.y - 270) / (aEnemy.renderPoint.x - 120)) * 57.2957795;
		if (angle < 0 && aEnemy.renderPoint.x - 120 < 0) {
			angle += 180;
		} else if (angle < 0 && aEnemy.renderPoint.y - 270 < 0) {
			angle += 360;
		} else if (aEnemy.renderPoint.x - 120 < 0 && aEnemy.renderPoint.y - 270 < 0) {
			angle += 180;
		}
        disorientRoll = [valkyrie calculateSowiloRollTo:aEnemy];
        staminaDown = [valkyrie calculateSowiloStaminaDownTo:aEnemy];
		rayOfLight.rotationPoint = CGPointMake(0, 0);
		rayOfLight.rotation = startAngle = angle;
		direction = 1;
		rayOfLight.scale = Scale2fMake(0.2, 0.2);
		rayOfLight.color = Color4fMake(1, 1, 1, 0.15);
		stage = 0;
		active = YES;
		duration = 0.6;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage = 1;
                    duration = 0.3;
                    break;
                case 1:
                    stage = 2;
                    if (disorientRoll > 0) {
                        [target1 youWereDisoriented:(int)disorientRoll];
                    } else {
                        [BattleStringAnimation makeIneffectiveStringAt:target1.renderPoint];
                    }
                    [target1 decreaseStaminaModifierBy:staminaDown];
                    duration = 15;
                    break;
                case 2:
                    stage = 3;
                    [target1 increaseStaminaModifierBy:staminaDown];
                    active = NO;
                    break;
                default:
                    break;
            }
        }
	
		switch (stage) {
			case 0:
				[sun updateWithDelta:aDelta];
				rayOfLight.scale = Scale2fMake(rayOfLight.scale.x + (10 * aDelta), rayOfLight.scale.y + (10 * aDelta));
				rayOfLight.renderPoint = CGPointMake(rayOfLight.renderPoint.x - (aDelta * 100), rayOfLight.renderPoint.y - (aDelta * 100));	
				break;
			case 1:
				[sun updateWithDelta:aDelta];
				rayOfLight.rotation = (rayOfLight.rotation + (aDelta * 3 * direction));
				if (abs(rayOfLight.rotation - startAngle) > 8) {
					direction *= -1;
				}
				break;
			case 2:
				//[sun updateWithDelta:aDelta];
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
				[sun renderParticlesWithImage:rayOfLight];
				break;
			case 1:
				[sun renderParticlesWithImage:rayOfLight];
				break;
			case 2:
				//[sun renderParticles];
				break;

			default:
				break;
		}
	}
}





@end
