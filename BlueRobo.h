//
//  BlueRobo.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 5/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractEntity.h"


@interface BlueRobo : AbstractEntity {

	int previousStage;
}

- (id)initAtLocation:(CGPoint)aLocation;

@end
