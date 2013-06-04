//
//  BuyARound.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "BuyARound.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleDwarf.h"
#import "Projectile.h"
#import "PackedSpriteSheet.h"

@implementation BuyARound

- (void)dealloc {
    if (drink) {
        [drink release];
    }
    [super dealloc];
}

+ (void)buyARound {
    
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
            BuyARound *aRound = [[BuyARound alloc] initToCharacter:character];
            [[GameController sharedGameController].currentScene addObjectToActiveObjects:aRound];
            [aRound release];
        }
    }
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {

    self = [super init];
    if (self) {
        BattleDwarf *dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
        healing = [dwarf calculateHealingTo:aCharacter];
        target1 = aCharacter;
        drink = [[Projectile alloc] initProjectileFrom:Vector2fMake(dwarf.renderPoint.x + 20, dwarf.renderPoint.y) to:Vector2fMake(aCharacter.renderPoint.x + 20, aCharacter.renderPoint.y) withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Antidote30x30.png"] lasting:0.5 withStartAngle:15 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(0.2, 0.2)];
        stage = 0;
        duration = 0.5;
        active = YES;
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
                    [target1 youWereHealed:healing];
                    duration = 0.5;
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
            [drink updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [drink renderProjectiles];
    }
}

@end
