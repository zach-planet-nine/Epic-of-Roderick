//
//  ElementalShield.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ElementalShield.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"


@implementation ElementalShield

- (void)dealloc {
	
	if (elementalShield) {
		[elementalShield release];
	}
	[super dealloc];
}

- (id)initFromCharacter:(AbstractBattleCharacter *)aCharacter withElement:(int)aElement {
	
	if (self = [super init]) {
		elementalShield = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"ElementalShield.pex"];
		elementalShield.sourcePosition = Vector2fMake(aCharacter.renderPoint.x + 23, aCharacter.renderPoint.y);
		switch (aElement) {
			case kWater:
				elementalShield.startColor = Color4fMake(0, 0.1, 1, 0.1);
				elementalShield.finishColor = Color4fMake(0, 0, 0.6, 0);
				break;
			case kPoison:
				elementalShield.startColor = Color4fMake(0, 0.1, 0, 1);
				elementalShield.finishColor = Color4fMake(0, 0.02, 0, 0);
				break;
			case kBone:
				elementalShield.startColor = Color4fMake(0.2, 0.2, 0, 1);
				elementalShield.finishColor = Color4fMake(0.2, 0.2, 0.2, 0);
				break;
			case kDeath:
				elementalShield.startColor = Color4fMake(0.4, 0, 0.4, 0.2);
				elementalShield.finishColor = Color4fMake(0.1, 0, 0.1, 0.1);
				break;
            case kSky:
                elementalShield.startColor = Color4fMake(0.1, 0.1, 1, 1);
                elementalShield.finishColor = Color4fMake(0.01, 0, 0.1, 0);
                break;
            case kLife:
                elementalShield.startColor = Color4fMake(0.8, 0.8, 0, 1);
                elementalShield.finishColor = Color4fMake(0.8, 0.8, 0.8, 0);
                break;
            case kRage:
                elementalShield.startColor = Color4fMake(0.5, 0.1, 0.1, 1);
                elementalShield.finishColor = Color4fMake(0.5, 0.01, 0.01, 0);
                break;
            case kFire:
                elementalShield.startColor = Color4fMake(1, 0, 0, 1);
                elementalShield.finishColor = Color4fMake(1, 0.4, 0, 0);
                break;
            case kStone:
                elementalShield.startColor = Color4fMake(0.3, 0.1, 0, 1);
                elementalShield.finishColor = Color4fMake(0.1, 0.05, 0, 0);
                break;
            case kWood:
                elementalShield.startColor = Color4fMake(0.2, 0.6, 0, 1);
                elementalShield.finishColor = Color4fMake(0.6, 0.2, 0, 0);
                break;
            case kDivine:
                elementalShield.startColor = Color4fMake(1, 1, 0.8, 1);
                elementalShield.finishColor = Color4fMake(1, 1, 0.8, 0);
			default:
				break;
		}
		stage = 0;
		active = YES;
		duration = 0.6;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				duration = 0.2;
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
				[elementalShield updateWithDelta:aDelta];
				break;
			case 1:
				[elementalShield updateWithDelta:aDelta];
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[elementalShield renderParticles];
	}
}

@end
