//
//  EnemyBite.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;
@class AbstractBattleEnemy;
@class AbstractBattleCharacter;

@interface EnemyBite : AbstractBattleAnimation {

	Image *lowerTeeth;
	Image *upperTeeth;
	//float duration;
	int damage;
	CGPoint fontRenderPoint;
	
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter;


@end
