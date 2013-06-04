//
//  JeraAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface JeraAllCharacters : AbstractBattleAnimation {
    
    NSMutableArray *statEmitters;
    CGPoint mods[3];
    float durations[3];
}

@end
