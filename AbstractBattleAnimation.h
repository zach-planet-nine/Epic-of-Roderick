//
//  AbstractBattleAnimation.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"

@class BitmapFont;
@class GameController;
@class AbstractBattleEntity;
@class AbstractBattleEnemy;
@class AbstractBattleCharacter;

@interface AbstractBattleAnimation : AbstractGameObject {
	
	GameController *sharedGameController;
	
	AbstractBattleEntity *originator;
	AbstractBattleEntity *target1;
	AbstractBattleEntity *target2;
	AbstractBattleEntity *target3;
	AbstractBattleEntity *target4;

}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy;

- (id)initEnemyArea;

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter;

- (id)initToCharacterArea;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (int)calculateDamageFrom:(int)aDealer to:(int)aReceiver;

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget;

- (void)resetAnimation;

@end
