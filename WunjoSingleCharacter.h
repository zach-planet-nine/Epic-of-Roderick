//
//  WunjoSingleCharacter.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;


@interface WunjoSingleCharacter : AbstractBattleAnimation {

	Image *bone;
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleCharacter *)aTarget;


@end
