//
//  WunjoSingleCharacter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WunjoSingleCharacter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "PackedSpriteSheet.h"
#import "AbstractBattleCharacter.h"
#import "Image.h"


@implementation WunjoSingleCharacter

- (void)dealloc {
	
	[super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
	
	if (self = [super init]) {
		bone = [sharedGameController.teorPSS imageForKey:@"Bone40x40.png"];
		originator = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
		target1 = aCharacter;
		bone.renderPoint = CGPointMake(target1.renderPoint.x + 40, target1.renderPoint.y);
		bone.rotationPoint = CGPointMake(20, 20);
		stage = 0;
		active = YES;
		duration = 0.5;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				[self calculateEffectFrom:originator to:target1];
				duration = 0.1;
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
				bone.rotation += aDelta * 2000;
				if (bone.rotation > 360) {
					bone.rotation -= 360;
				}
				break;
			default:
				break;
		}
	}
}

- (void)render {
	
	if (active && stage == 0) {
		[bone renderCenteredAtPoint:bone.renderPoint];
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleCharacter *)aTarget {
	
	[aTarget flashColor:Color4fMake(0, 0, 0, 1)];
	[aTarget youReceivedShield:kBone];
}

@end
