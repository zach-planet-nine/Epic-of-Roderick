//
//  Spear.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Animation;
@class Image;


@interface Spear : AbstractBattleAnimation {
	
	Animation *animation;
	Image *spearImage;
	CGPoint renderPoint;
	//float duration;
	CGPoint fontRenderPoint;

}

- (id)initWithCharacter:(int)aCharacter enemy:(int)aEnemy atPoint:(CGPoint)aPoint;

@end
