//
//  NordrinAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"


@interface NordrinAllCharacters : AbstractBattleAnimation {
    
    NSMutableArray *defenseEmitters;
	int mod[2];
}

- (void)calculateEffects;

@end
