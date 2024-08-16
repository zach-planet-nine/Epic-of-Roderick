//
//  Frog.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimalEntity.h"

@class BattleRanger;

@interface Frog : AbstractBattleAnimalEntity {

	Image *defaultImage;
	BOOL isHopping;
	Vector2f velocity;
	float gravity;
	float hopDuration;
	CGPoint destination;
	BattleRanger *ranger;
}

@property (nonatomic, retain) Image *defaultImage;

- (void)hopToPoint:(CGPoint)aPoint;

- (void)hopBackToRanger;

@end
