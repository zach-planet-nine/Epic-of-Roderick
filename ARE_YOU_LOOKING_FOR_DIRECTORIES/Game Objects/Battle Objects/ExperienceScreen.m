//
//  ExperienceScreen.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ExperienceScreen.h"
#import "GameController.h"
#import "FontManager.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "Character.h"
#import "BitmapFont.h"
#import "Image.h"
#import "Textbox.h"

@implementation ExperienceScreen


- (id)init
{
    self = [super init];
    if (self) {
        experience = 0;
        for (AbstractBattleEnemy *enemy in [GameController sharedGameController].currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                experience += enemy.experience;
            }
        }
        active = YES;
    }
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active && experience > 0) {
        experienceDelta = (int)(aDelta * 100);
        if (experienceDelta < experience) {
            experience -= experienceDelta;
        }
        else {
            experienceDelta = experience;
            experience = 0;
        }
        for (int i = 0; i < [[GameController sharedGameController].party count]; i++) {
            Character *charac = [[GameController sharedGameController].party objectAtIndex:i];
            if (i < 3) {
                charac.experience += experienceDelta;
                charac.toNextLevel -= experienceDelta;
                if (charac.toNextLevel < 0) {
                    [charac levelUp];
                    Textbox *levelUp = [[Textbox alloc] initWithRect:CGRectMake(220, (233 - (94 * i)), 110, 40) color:Color4fMake(0.3, 0.3, 0.3, 1) duration:1.3 animating:NO text:@"Leveled Up!"];
                    [sharedGameController.currentScene addObjectToActiveObjects:levelUp];
                    [levelUp release];
                }
            }
            else {
                charac.experience += (int)((float)(experienceDelta) / 2);
                charac.toNextLevel -= (int)((float)(experienceDelta) / 2);
                if (charac.toNextLevel < 0) {
                    [charac levelUp];
                }
            }
        }
    }
}

- (void)render {
    if (active) {
        int renderY = 263;
        [backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
        for (Character *charac in [GameController sharedGameController].party) {
            [charac.characterImage renderCenteredAtPoint:CGPointMake(60, renderY)];
            [[[FontManager sharedFontManager] getFontWithKey:@"menuFont"] renderStringAt:CGPointMake(160, renderY) text:[NSString stringWithFormat:@"%d/%d", charac.experience, charac.toNextLevel]];
            renderY -= 94;
            if (renderY < 0) {
                break;
            }
        }
        [[[FontManager sharedFontManager] getFontWithKey:@"menuFont"] renderStringAt:CGPointMake(350, 280) text:[NSString stringWithFormat:@"Experience gained: %d", experience]];
    }
}

- (void)youWereTappedAt:(CGPoint)aTapLocation {
    
    //NSLog(@"Touch received.");
    while (experience > 0) {
        
        for (int i = 0; i < [[GameController sharedGameController].party count]; i++) {
            Character *charac = [[GameController sharedGameController].party objectAtIndex:i];
            if (i < 3) {
                charac.experience ++;
                charac.toNextLevel--; 
            }
            else {
                charac.experience += (int)experience % 2;
            }
            if (charac.toNextLevel < 0) {
                [charac levelUp];
            }
            experience--;
        }
    } 
    active = NO;
    [[GameController sharedGameController].currentScene restoreMap];
        
}

@end
