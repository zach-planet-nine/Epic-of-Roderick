//
//  Motivate.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "Motivate.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleDwarf.h"
#import "Textbox.h"


@implementation Motivate

- (void)dealloc {
    [super dealloc];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
        velocity = Vector2fMake((220 - dwarf.renderPoint.x) * 2, (160 - dwarf.renderPoint.y) * 2);
        originalPoint = dwarf.renderPoint;
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
                    velocity = Vector2fMultiply(velocity, -1);
                    [Textbox textboxWithText:@"The sooner we win, the sooner we drink!"];
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                            [character youWereMotivated:[dwarf calculateMotivationDurationTo:character]];
                        }
                    }
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    dwarf.renderPoint = originalPoint;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    [sharedGameController.currentScene removeTextbox];
                    duration = 0.5;
                    break;
                case 3:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        if (stage < 2) {
            Vector2f temp = Vector2fMake(velocity.x * aDelta, velocity.y * aDelta);
            dwarf.renderPoint = CGPointMake(dwarf.renderPoint.x + temp.x, dwarf.renderPoint.y + temp.y);
        }
    }
}


@end
