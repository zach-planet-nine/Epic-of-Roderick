//
//  SmeazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SmeazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "Image.h"
#import "BattleStringAnimation.h"

@implementation SmeazSingleCharacter

- (void)dealloc {
    
    if (smeazAngel) {
        [smeazAngel release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aCharacter;
        if (poet.essence > 15) {
            smeazAngel = [[Image alloc] initWithImageNamed:@"SmeazAngel.png" filter:GL_NEAREST];
            smeazAngel.renderPoint = CGPointMake(aCharacter.renderPoint.x + 30, aCharacter.renderPoint.y + 30);
            stage = 0;
            duration = 0.6;
            active = YES;
        } else {
            [BattleStringAnimation makeIneffectiveStringAt:aCharacter.renderPoint];
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
                    [target1 gainAutoRaise];
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
        switch (stage) {
            case 0:
                smeazAngel.renderPoint = CGPointMake(smeazAngel.renderPoint.x + (aDelta * RANDOM_MINUS_1_TO_1() * 5), smeazAngel.renderPoint.y + (aDelta * RANDOM_MINUS_1_TO_1() * 5));
                break;
            case 1:
                smeazAngel.color = Color4fMake(1, 1, 1, smeazAngel.color.alpha - aDelta * 2);
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [smeazAngel renderCenteredAtPoint:smeazAngel.renderPoint];
    }
}

@end
