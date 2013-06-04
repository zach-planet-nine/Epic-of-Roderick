//
//  GromanthAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface GromanthAllCharacters : AbstractBattleAnimation {
    
    NSMutableArray *statEmitters;
    float timers[3];
    CGPoint characters[3];
}

@end
