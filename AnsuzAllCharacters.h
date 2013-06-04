//
//  AnsuzAllCharacters.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"


@interface AnsuzAllCharacters : AbstractBattleAnimation {

	NSMutableArray *strengthEmitters;
	int mod[2];
}

- (void)calculateEffects;

@end
