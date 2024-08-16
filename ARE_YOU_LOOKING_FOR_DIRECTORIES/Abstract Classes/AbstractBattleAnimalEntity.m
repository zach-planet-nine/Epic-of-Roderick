//
//  AbstractBattleAnimalEntity.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimalEntity.h"
#import "AbstractBattleEntity.h"


@implementation AbstractBattleAnimalEntity

@synthesize target;
@synthesize allEnemies;
@synthesize allCharacters;

- (id)init {
    
    self = [super init];
    if (self) {
        
        allEnemies = NO;
        allCharacters = NO;
        battleTimer = 0;
        attackPower = 1;
        helpPower = 1;
    }
    return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
    battleTimer += aDelta;
	if (battleTimer > 8.0) {
		[self timerFired];
		battleTimer = 0 + (RANDOM_0_TO_1() * 2);
	}
}

- (void)setTarget:(AbstractBattleEntity *)aEntity {
	
	target = aEntity;
	allEnemies = NO;
	allCharacters = NO;
}

- (void)timerFired {}

- (void)beSummoned {}

- (void)depart {}

- (void)joinBattle {
    target = nil;
    allEnemies = NO;
    allCharacters = NO;
}

@end
