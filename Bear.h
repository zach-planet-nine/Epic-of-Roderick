//
//  Bear.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimalEntity.h"

@class Image;
@class BattleRanger;

@interface Bear : AbstractBattleAnimalEntity {
    
    Image *defaultImage;
	CGPoint destination;
	BattleRanger *ranger;
    Vector2f velocity;
    BOOL returnToRanger;
}

@property (nonatomic, retain) Image *defaultImage;

- (void)bearMoveToPoint:(CGPoint)aPoint;

- (void)bearMoveBackToRanger;

@end
