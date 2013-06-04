//
//  EhwazAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@interface EhwazAllCharacters : AbstractBattleAnimation {
    
    NSMutableArray *defenseEmitters;
	int mod[2];
}

- (void)calculateEffects;

@end
