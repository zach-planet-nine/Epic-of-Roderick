//
//  WeaponElement.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WeaponElement.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"


@implementation WeaponElement

- (void)dealloc {
	
	if (elementEmitter) {
		[elementEmitter release];
	}
	[super dealloc];
}

- (id)initFromCharacter:(AbstractBattleCharacter *)aCharacter withElement:(int)aElement {
	
	if (self = [super init]) {
		//Add weapon image here so that elemnt goes into weapon.
		elementEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"ElementalEmitter.pex"];
		switch (aElement) {
            case kWater:
                elementEmitter.startColor = Color4fMake(0, 0.1, 1, 1);
				elementEmitter.finishColor = Color4fMake(0, 0.02, 0.1, 0);
                break;
			case kPoison:
				elementEmitter.startColor = Color4fMake(0, 0.1, 0, 1);
				elementEmitter.finishColor = Color4fMake(0, 0.02, 0, 0);
				break;
            case kSky:
                elementEmitter.startColor = Color4fMake(0.1, 0.1, 1, 1);
                elementEmitter.finishColor = Color4fMake(0.01, 0, 0.1, 0);
                break;
            case kLife:
                elementEmitter.startColor = Color4fMake(0.8, 0.8, 0, 1);
                elementEmitter.finishColor = Color4fMake(0.8, 0.8, 0.8, 0);
                break;
            case kRage:
                elementEmitter.startColor = Color4fMake(0.5, 0.1, 0.1, 1);
                elementEmitter.finishColor = Color4fMake(0.5, 0.01, 0.01, 0);
                break;
            case kFire:
                elementEmitter.startColor = Color4fMake(1, 0, 0, 1);
                elementEmitter.finishColor = Color4fMake(1, 0.4, 0, 0);
                break;
            case kStone:
                elementEmitter.startColor = Color4fMake(0.4, 0.15, 0, 1);
                elementEmitter.finishColor = Color4fMake(0.1, 0.05, 0, 0);
                break;
            case kWood:
                elementEmitter.startColor = Color4fMake(0.2, 0.6, 0, 1);
                elementEmitter.finishColor = Color4fMake(0.6, 0.2, 0, 0);
                break;
            case kDivine:
                elementEmitter.startColor = Color4fMake(1, 1, 0.8, 1);
                elementEmitter.finishColor = Color4fMake(1, 1, 0.8, 0);
                break;
            case kDeath:
                elementEmitter.startColor = Color4fMake(0.4, 0, 0.4, 0.2);
				elementEmitter.finishColor = Color4fMake(0.1, 0, 0.1, 0.1);
			default:
				break;
		}
		elementEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x + 50, aCharacter.renderPoint.y + 50);
		stage = 0;
		duration = 0.6;
		active = YES;
		
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				duration = 0.5;
				break;
			case 1:
				stage = 2;
				active = NO;
				break;

			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[elementEmitter updateWithDelta:aDelta];
				break;
			case 1:
				elementEmitter.maxRadius -= aDelta * 600;
				[elementEmitter updateWithDelta:aDelta];
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[elementEmitter renderParticles];
	}
}

@end
