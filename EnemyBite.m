//
//  EnemyBite.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyBite.h"
#import "Image.h"
#import "BitmapFont.h"
#import "AbstractBattleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"


@implementation EnemyBite


- (void)dealloc {
	
	if (lowerTeeth) {
		[lowerTeeth release];
	}
	if (upperTeeth) {
		[upperTeeth release];
	}
	
	[super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter {
	
	if (self = [super init]) {
		
        target1 = aCharacter;
		lowerTeeth = [[Image alloc] initWithImageNamed:@"LowerTeeth.png" filter:GL_LINEAR];
		upperTeeth = [[Image alloc] initWithImageNamed:@"UpperTeeth.png" filter:GL_LINEAR];
		lowerTeeth.renderPoint = CGPointMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y + 30);
        upperTeeth.renderPoint = CGPointMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        
        damage = [aEnemy calculateBiteDamageToCharacter:aCharacter];
		stage = 10;
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
                    [target1 flashColor:Red];
                    [target1 youTookDamage:damage];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                case 10:
                    stage = 0;
                    duration = 0.5;
                    break;
                default:
                    break;
            }
        }
        if (stage == 0) {
            lowerTeeth.renderPoint = CGPointMake(lowerTeeth.renderPoint.x, lowerTeeth.renderPoint.y - aDelta * 30);
            upperTeeth.renderPoint = CGPointMake(upperTeeth.renderPoint.x, upperTeeth.renderPoint.y + aDelta * 30);
        }
	}
}

- (void)render {
	
	if (active && stage == 0) {
		[lowerTeeth renderCenteredAtPoint:lowerTeeth.renderPoint];
        [upperTeeth renderCenteredAtPoint:upperTeeth.renderPoint];
	}
}


@end
