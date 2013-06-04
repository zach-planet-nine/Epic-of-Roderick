//
//  SowiloAllCharacters.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SowiloAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleValkyrie.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"
#import "Image.h"


@implementation SowiloAllCharacters
- (void)dealloc {
	
	if (sun) {
		[sun release];
	}
	if (yellowPixel) {
		[yellowPixel release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		valkyrie = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
		sun = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"Sun.pex" fromPoint:CGPointMake(200, 290) toPoint:CGPointMake(200, 290)];
		yellowPixel = [[Image alloc] initWithImageNamed:@"WhitePixelFadingRight.png" filter:GL_LINEAR];
		yellowPixel.color = Color4fMake(1, 1, 0, 0);
		yellowPixel.scale = Scale2fMake(20, 320);
		yellowPixel.renderPoint = CGPointMake(50, 160);
        [self calculateEffect];
		
		stage = 0;
		duration = 0.2;
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
				duration = 0.6;
				break;
				
			case 1:
				duration = 0.2;
				stage = 2;
                int healingIndex = 0;
                for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                    if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                        [character youWereHealed:(int)healings[healingIndex]];
                        healingIndex++;
                    }
                }
				break;
			case 2:
				stage = 3;
				active = NO;
				break;
				
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[sun updateWithDelta:aDelta];
				break;
			case 1:
				[sun updateWithDelta:aDelta];
				yellowPixel.color = Color4fMake(1, 1, 0, yellowPixel.color.alpha + (aDelta / 3));
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
				[sun renderParticles];
				break;
			case 1:
				[sun renderParticles];
				[yellowPixel renderCenteredAtPoint:yellowPixel.renderPoint];
				break;
			case 2:
				[sun renderParticles];
				break;
				
				
			default:
				break;
		}
		
	}
}

- (void)calculateEffect {
	
    int healingIndex = 0;
    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
			float healing = ((valkyrie.affinity + valkyrie.affinityModifier + valkyrie.lifeAffinity) * 4 * (valkyrie.essence / valkyrie.maxEssence));
			healings[healingIndex] = healing;
            healingIndex++;
			
		}
	}
}

@end
