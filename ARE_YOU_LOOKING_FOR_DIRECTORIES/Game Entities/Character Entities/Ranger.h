//
//  Ranger.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/15/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractEntity.h"

@interface Ranger : AbstractEntity

- (id)initAtLocation:(CGPoint)aLocation;

+ (void)valkyrieAppearAt:(CGPoint)aLocation move:(int)aDirection andFace:(int)aFacing;

+ (void)joinParty;

+ (void)move:(int)aDirection;

@end
