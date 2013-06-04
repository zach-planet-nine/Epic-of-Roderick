//
//  Valkyrie.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/16/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractEntity.h"

@interface Valkyrie : AbstractEntity

- (id)initAtLocation:(CGPoint)aLocation;

+ (void)valkyrieAppearAt:(CGPoint)aLocation move:(int)aDirection andFace:(int)aFacing;

+ (void)joinParty;

+ (void)move:(int)aDirection;

@end
