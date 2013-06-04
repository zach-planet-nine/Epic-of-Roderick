//
//  EnemySmash.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Image;

@interface EnemySmash : AbstractBattleAnimation {
    
    Image *fist;
    int damage;
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter;

@end
