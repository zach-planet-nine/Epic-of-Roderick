//
//  BerkanoSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BerkanoSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "Image.h"
#import "Projectile.h"
#import "BattleStringAnimation.h"

@implementation BerkanoSingleCharacter

- (void)dealloc {
    
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        target1 = aCharacter;
        //NSLog(@"Here?");
        if (!aCharacter.isAlive) {
            //Init all the images and projectiles here
            healing = [valk calculateBerkanoHealingTo:aCharacter];
            stage = 0;
            duration = 1;
            active = YES;
        } else {
            
            [BattleStringAnimation makeIneffectiveStringAt:aCharacter.renderPoint];
            //NSLog(@"Should get string");
            stage = 5;
            active = NO;
        }
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    [target1 youHaveBeenRevived];
                    [target1 youWereHealed:healing];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
    }
}

@end
