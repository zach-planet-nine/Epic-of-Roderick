//
//  EkwazAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface EkwazAllCharacters : AbstractBattleAnimation {
    
    NSMutableArray *statRaisedEmitters;
    CGPoint mods[3];
    float modDurations[3];
}

@end
