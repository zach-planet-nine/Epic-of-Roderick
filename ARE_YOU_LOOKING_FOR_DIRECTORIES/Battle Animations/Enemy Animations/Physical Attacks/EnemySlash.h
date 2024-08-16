//
//  EnemySlash.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/14/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Animation;

@interface EnemySlash : AbstractBattleAnimation {
    
    Animation *slash;
    int damage;
    CGPoint renderPoint;
	float rotation;
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter;

@end
