//
//  EihwazSingleCharacter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EihwazSingleCharacter.h"
#import "AbstractBattleCharacter.h"
#import "Global.h"


@implementation EihwazSingleCharacter

+ (void)grantPoisonElementTo:(AbstractBattleCharacter *)aCharacter {
	
	[aCharacter youReceivedWeaponElement:kPoison];
}
	 
	
@end
