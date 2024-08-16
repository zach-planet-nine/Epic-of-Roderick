//
//  Squirrel.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimalEntity.h"

@class Image;
@class BattleRanger;

@interface Squirrel : AbstractBattleAnimalEntity {
    
    Image *defaultImage;
	CGPoint destination;
	BattleRanger *ranger;
}

@property (nonatomic, retain) Image *defaultImage;

@end
