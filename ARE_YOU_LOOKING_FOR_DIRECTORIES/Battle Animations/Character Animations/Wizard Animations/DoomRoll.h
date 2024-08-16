//
//  DoomRoll.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;
@class Image;


@interface DoomRoll : AbstractBattleAnimation {

	Image *doom;
	Projectile *scythe;
}

- (void)calculateEffect;

@end
