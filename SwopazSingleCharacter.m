//
//  SwopazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SwopazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"
#import "Image.h"

@implementation SwopazSingleCharacter

- (void)dealloc {
    
    if (bloodDrop) {
        [bloodDrop release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        target1 = aCharacter;
        swopazDuration = [ranger calculateSwopazDurationTo:aCharacter];
        bloodDrop = [[Image alloc] initWithImageNamed:@"BloodDrop.png" filter:GL_NEAREST];
        bloodDrop.renderPoint = CGPointMake(aCharacter.renderPoint.x - 20, aCharacter.renderPoint.y + 20);
        bloodDropAlpha = 0;
        stage = 0;
        duration = 1;
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
                    [target1 attacksWillCauseBleeders];
                    duration = swopazDuration;
                    break;
                case 1:
                    stage++;
                    [target1 attacksWillNotCauseBleeders];
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                bloodDropAlpha += aDelta;
                if (bloodDrop.color.alpha != 0 && bloodDropAlpha < 0.5) {
                    bloodDrop.color = Color4fMake(1, 1, 1, 0);
                } else {
                    bloodDrop.color = Color4fMake(1, 1, 1, bloodDropAlpha);
                }
                break;
            case 2:
                bloodDropAlpha -= aDelta;
                if (bloodDrop.color.alpha != 0 && bloodDropAlpha < 0.5) {
                    bloodDrop.color = Color4fMake(1, 1, 1, 0);
                } else {
                    bloodDrop.color = Color4fMake(1, 1, 1, bloodDropAlpha);
                }
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [bloodDrop renderCenteredAtPoint:bloodDrop.renderPoint];
    }
}

@end
