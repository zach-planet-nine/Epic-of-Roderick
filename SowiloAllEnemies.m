//
//  SowiloAllEnemies.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SowiloAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "ParticleEmitter.h"
#import "Image.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "BattleStringAnimation.h"


@implementation SowiloAllEnemies

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
		sun = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"Sun.pex" fromPoint:CGPointMake(100, 290) toPoint:CGPointMake(100, 290)];
		yellowPixel = [[Image alloc] initWithImageNamed:@"WhitePixel.png" filter:GL_LINEAR];
		yellowPixel.color = Color4fMake(1, 1, 0, 0);
		yellowPixel.scale = Scale2fMake(240, 320);
		yellowPixel.renderPoint = CGPointMake(360, 160);
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                sowiloRolls[enemyIndex] = [valkyrie calculateSowiloRollTo:enemy];
                enemyIndex++;
            }
        }
		
		stage = 0;
		duration = 0.2;
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
                    stage = 1;
                    duration = 0.6;
                    break;
                    
                case 1:
                    stage = 2;
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            if (sowiloRolls[enemyIndex] > 0) {
                                [enemy youWereDisoriented:(int)sowiloRolls[enemyIndex]];
                            } else {
                                [BattleStringAnimation makeIneffectiveStringAt:enemy.renderPoint];
                            }
                            enemyIndex++;
                        }
                    }
                    duration = 0.2;
                    break;
                case 2:
                    stage = 3;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
	
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


@end
