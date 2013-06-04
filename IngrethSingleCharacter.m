//
//  IngrethSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngrethSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "Image.h"
#import "BattleStringAnimation.h"


@implementation IngrethSingleCharacter

- (void)dealloc {
    
    if (hexImage) {
        [hexImage release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        if (poet.essence > 10 && aCharacter.isHexed) {
            hexImage = [[Image alloc] initWithImageNamed:@"Hex.png" filter:GL_NEAREST];
            hexImage.renderPoint = aCharacter.renderPoint;
            aCharacter.isHexed = NO;
            stage = 0;
            duration = 1;
            active = YES;
        } else {
            [BattleStringAnimation makeIneffectiveStringAt:aCharacter.renderPoint];
            stage = 2;
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
            hexImage.color = Color4fMake(hexImage.color.red - aDelta, hexImage.color.green - aDelta, hexImage.color.blue - aDelta, 1);
            hexImage.scale = Scale2fMake(hexImage.scale.x - aDelta, hexImage.scale.y - aDelta);
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [hexImage renderCenteredAtPoint:hexImage.renderPoint];
    }
}

@end
