//
//  Seior.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractEntity.h"

@interface Seior : AbstractEntity

+ (void)seiorAppearAt:(CGPoint)aLocation move:(int)aDirection andFace:(int)aFacing;

+ (void)joinParty;

+ (void)move:(int)aDirection;

@end
