//
//  NPCBlackHairedRoderick.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractEntity.h"

@interface NPCBlackHairedRoderick : AbstractEntity {
    
    int previousStage;
}

- (id)initAtLocation:(CGPoint)aLocation;

@end
