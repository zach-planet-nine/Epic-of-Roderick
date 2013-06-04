//
//  DagazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DagazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Image.h"
#import "BattleStringAnimation.h"

@implementation DagazSingleEnemy

- (void)dealloc {
    
    if (hex) {
        [hex release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aEnemy;
        hexRoll = [poet calculateDagazHexRollTo:aEnemy];
        if (hexRoll > 0) {
            hex = [[Image alloc] initWithImageNamed:@"Hex.png" filter:GL_NEAREST];
            hex.scale = Scale2fMake(0.3, 0.3);
            hex.color = Color4fMake(0, 0, 0, 1);
            hex.renderPoint = aEnemy.renderPoint;
            stage = 0;
            duration = 0.5;
            active = YES;
        } else {
            [BattleStringAnimation makeIneffectiveStringAt:aEnemy.renderPoint];
            stage = 3;
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
                    [target1 youWereHexed:hexRoll];
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    duration = 0.2;
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
                hex.scale = Scale2fMake(hex.scale.x + (aDelta * 2.3), hex.scale.y + (aDelta * 2.3));
                hex.color = Color4fMake(hex.color.red + (aDelta * 2), hex.color.green + (aDelta * 2), hex.color.blue + (aDelta * 2), 1);
                break;
            case 1:
                hex.scale = Scale2fMake(hex.scale.x - aDelta, hex.scale.y - aDelta);
                break;
            case 2:
                hex.color = Color4fMake(hex.color.red - (aDelta * 5), hex.color.green - (aDelta * 5), hex.color.blue - (aDelta * 5), hex.color.alpha - (aDelta * 5));
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 3) {
        [hex renderCenteredAtPoint:hex.renderPoint];
    }
}

@end
