//
//  TreasureChest.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 5/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractEntity.h"


@interface TreasureChest : AbstractEntity {

	int item;
	float duration;
}

- (id)initAtPosition:(CGPoint)aPosition withItem:(int)aItem;


@end
