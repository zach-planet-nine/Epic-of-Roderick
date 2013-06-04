//
//  Comet.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Comet.h"
#import "ParticleEmitter.h"
#import "BitmapFont.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleEntity.h"
#import "AbstractBattleCharacter.h"


@implementation Comet

-(void)dealloc {
	
	if (comet) {
		[comet release];
	}
	if (explosion) {
		[explosion release];
	}
	
	[super dealloc];
}

/*- (id)initWithCharacter:(int)aCharacter toEnemy:(int)aEnemy {
	
	if (self = [super init]) {
		comet = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Comet.pex"];
		comet.sourcePosition = Vector2fMake(0, 320);
		for (AbstractBattleEnemy *entity in sharedGameController.currentScene.activeEntities) {
			if ([entity isKindOfClass:[AbstractBattleEnemy class]]) {
				//NSLog(@"Which enemy is: %d.", entity.whichEnemy);
				if (entity.whichEnemy == aEnemy) {
					//NSLog(@"Render Point is: (%f, %f).", entity.renderPoint.x, entity.renderPoint.y);
					velocity = Vector2fMake(entity.renderPoint.x / 1.3, ((entity.renderPoint.y - 40) - 320)  / 1.3);
				}
			}
			
		}
		//velocity = Vector2fMake(310 / 1.3, -(220 / 1.3));
		duration = 1.3;
		stage = 0;
		active = YES;
	}
	
	return self;
}*/

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		comet = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Comet.pex"];
		comet.sourcePosition = Vector2fMake(0, 320);
		velocity = Vector2fMake(aEnemy.renderPoint.x / 1.3, ((aEnemy.renderPoint.y - 40) - 320)  / 1.3);
		duration = 1.3;
		stage = 0;
		active = YES;
		AbstractBattleCharacter *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
		[self calculateEffectFrom:wizard to:aEnemy];
		fontRenderPoint = CGPointMake(aEnemy.renderPoint.x + 20, aEnemy.renderPoint.y);
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				explosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Explosion.pex"];
				explosion.sourcePosition = comet.sourcePosition;
				duration = 0.3;
				stage = 1;
				break;
			case 1:
				duration = 0.6;
				stage = 2;
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
				comet.sourcePosition = Vector2fMake(comet.sourcePosition.x + (velocity.x * aDelta), comet.sourcePosition.y + (velocity.y * aDelta));
				[comet updateWithDelta:aDelta];
				break;
			case 1:
				[explosion updateWithDelta:aDelta];
				break;
			case 2:
				fontRenderPoint.y -= aDelta * 10;
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
				[comet renderParticles];
				break;
			case 1:
				[explosion renderParticles];
				break;
			case 2:
			//	[battleFont renderStringAt:fontRenderPoint text:[NSString stringWithFormat:@"%d", damage]];
				break;

			default:
				break;
		}
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	damage = (int)(aOriginator.power * 4 * (aOriginator.essence / aOriginator.maxEssence) - aTarget.level);
	aTarget.hp -= damage;
	//NSLog(@"New hp = %d", aTarget.hp);
}
	

@end
