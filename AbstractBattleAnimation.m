//
//  AbstractBattleAnimation.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"
#import "SoundManager.h"
#import "GameController.h"
#import "BitmapFont.h"
#import "AbstractScene.h"


@implementation AbstractBattleAnimation


- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
	//	battleFont = sharedGameController.currentScene.battleFont;

	}
	
	return self;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	return [self init];
}

- (id)initEnemyArea {
	return [self init];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
	return [self init];
}

- (id)initToCharacterArea {
	return [self init];
}

- (void)updateWithDelta:(float)aDelta {}

- (void)render {}

- (int)calculateDamageFrom:(int)aDealer to:(int)aReceiver {
	return 30;
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
}

- (void)resetAnimation {}

@end
