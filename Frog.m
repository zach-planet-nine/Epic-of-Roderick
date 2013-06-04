//
//  Frog.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Frog.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "AbstractScene.h"
#import "Image.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "BattleRanger.h"
#import "FrogSingleEnemy.h"
#import "FrogAllEnemies.h"
#import "FrogSingleCharacter.h"
#import "FrogAllCharacters.h"
#import "FrogDepartingAnimation.h"


@implementation Frog

@synthesize defaultImage;

- (void)dealloc {
    
    if (defaultImage) {
        [defaultImage release];
    }
    [super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		defaultImage = [[[sharedGameController.teorPSS imageForKey:@"Frog40x40.png"] imageDuplicate] retain];
		agility = 4;
		essence = 20;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {

	[super updateWithDelta:aDelta];
	if (isHopping) {
		hopDuration -= aDelta;
		velocity = Vector2fMake(velocity.x, velocity.y + (gravity * aDelta));
		renderPoint = CGPointMake(renderPoint.x + (velocity.x * aDelta), renderPoint.y + (velocity.y * aDelta));
		if (hopDuration < 0) {
			renderPoint = destination;
			isHopping = NO;
		}
	}
}

- (void)render {
	
	[defaultImage renderCenteredAtPoint:renderPoint];
}

- (void)timerFired {
	
	////NSLog(@"Timer fired!");
	if (!allEnemies && !allCharacters) {
		////NSLog(@"Bools are off.");
		if ([target isKindOfClass:[AbstractBattleEnemy class]]) {
			////NSLog(@"The problem is with the animation.");
			FrogSingleEnemy *fse = [[FrogSingleEnemy alloc] initToEnemy:target from:self];
			[sharedGameController.currentScene addObjectToActiveObjects:fse];
			[fse release];
		}
		if ([target isKindOfClass:[AbstractBattleCharacter class]]) {
			FrogSingleCharacter *fsc = [[FrogSingleCharacter alloc] initToCharacter:target from:self];
			[sharedGameController.currentScene addObjectToActiveObjects:fsc];
			[fsc release];
		}
	}
	else if (allEnemies) {
		FrogAllEnemies *fae = [[FrogAllEnemies alloc] initFrom:self];
		[sharedGameController.currentScene addObjectToActiveObjects:fae];
		[fae release];
	} else if (allCharacters) {
		[FrogAllCharacters grantWaterShields];
	}
}

- (void)hopToPoint:(CGPoint)aPoint {
		
	velocity = Vector2fMake((aPoint.x - renderPoint.x) / 0.3, (abs((aPoint.x - renderPoint.x) / 0.3)) * 2);
	gravity = (2 * (aPoint.y - renderPoint.y - (velocity.y * 0.3))) / (powf(0.3, 2));
	destination = aPoint;
	isHopping = YES;
	hopDuration = 0.3;
}

- (void)hopBackToRanger {
	
	ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
	[self hopToPoint:CGPointMake(ranger.renderPoint.x, ranger.renderPoint.y - 30)];
	//NSLog(@"Ranger renderPoint is: (%f, %f).", ranger.renderPoint.x, ranger.renderPoint.y);
}

- (void)beSummoned {
    
    renderPoint = CGPointMake(-100, 160);
    [self hopBackToRanger];
}

- (void)depart {
    
    FrogDepartingAnimation *fda = [[FrogDepartingAnimation alloc] initFrom:self];
    [sharedGameController.currentScene addObjectToActiveObjects:fda];
    [fda release];
}

@end
