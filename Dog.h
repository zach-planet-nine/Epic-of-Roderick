//
//  Dog.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimalEntity.h"

@class BattleRanger;
@class Image;

@interface Dog : AbstractBattleAnimalEntity {
    
	Image *defaultImage;
	CGPoint destination;
	BattleRanger *ranger;
}

@property (nonatomic, retain) Image *defaultImage;

@end
