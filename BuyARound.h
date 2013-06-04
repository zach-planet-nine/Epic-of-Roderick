//
//  BuyARound.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Projectile;

@interface BuyARound : AbstractBattleAnimation {
    
    int healing;
    Projectile *drink;
}

+ (void)buyARound;

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter;

@end
