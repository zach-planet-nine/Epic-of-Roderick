//
//  LaguzSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "LaguzSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Image.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation LaguzSingleEnemy

- (void)dealloc {
	
	if (mole) {
		[mole release];
	}
	if (groundBreaking) {
		[groundBreaking release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
		target1 = aEnemy;
		mole = [[Image alloc] initWithImageNamed:@"Mole.png" filter:GL_LINEAR];
		groundBreaking = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"GroundBreaking.pex"];
		groundBreaking.sourcePosition = Vector2fMake(target1.renderPoint.x + 50, target1.renderPoint.y - 60);
		mole.renderPoint = CGPointMake(target1.renderPoint.x + 50, target1.renderPoint.y - 60);
        enduranceDamage = [ranger calculateLaguzEnduranceDamageTo:aEnemy];
		stage = 0;
		active = YES;
		duration = 0.3;
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
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    duration = 0.4;
                    break;
                case 2:
                    stage++;
                    target1.endurance -= enduranceDamage;
                    BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"Endurance Down!" from:target1.renderPoint];
                    [sharedGameController.currentScene addObjectToActiveObjects:bsa];
                    [bsa release];
                    duration = 0.3;
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
				[groundBreaking updateWithDelta:aDelta];
				break;
			case 1:
				mole.renderPoint = CGPointMake(mole.renderPoint.x, mole.renderPoint.y + (aDelta * 50));
				[groundBreaking updateWithDelta:aDelta];
				break;
			case 2:
				mole.renderPoint = CGPointMake(mole.renderPoint.x - (aDelta * 50), mole.renderPoint.y);
				break;
			case 3:
				mole.color = Color4fMake(1, 1, 1, mole.color.alpha - aDelta * 5);
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
				[groundBreaking renderParticles];
				break;
			case 1:
				[groundBreaking renderParticlesWithImage:mole];
				break;
			case 2:
				[mole renderCenteredAtPoint:mole.renderPoint];
				break;
			case 3:
				[mole renderCenteredAtPoint:mole.renderPoint];
				break;
			default:
				break;
		}
	}
}

@end
