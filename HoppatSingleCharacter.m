//
//  HoppatSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HoppatSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"
#import "Projectile.h"
#import "BattleStringAnimation.h"

@implementation HoppatSingleCharacter

- (void)dealloc {
    
    if (sloth) {
        [sloth release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        target1 = aCharacter;
        if (ranger.essence < 5 || !aCharacter.isSlothed) {
            [BattleStringAnimation makeIneffectiveStringAt:aCharacter.renderPoint];
            stage = 2;
            active = NO;
        } else {
            sloth = [[Projectile alloc] initProjectileFrom:Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y) to:Vector2fMake(300, 500) withImage:@"Sloth.png" lasting:1 withStartAngle:0 withStartSize:Scale2fMake(0.1, 0.1) toFinishSize:Scale2fMake(1, 1)];
            stage = 0;
            duration = 1;
            active = YES;
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
                    [target1 flashColor:Color4fMake(1, 0, 1, 1)];
                    target1.isSlothed = NO;
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        if (stage == 0) {
            [sloth updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [sloth renderProjectiles];
    }
}

@end
