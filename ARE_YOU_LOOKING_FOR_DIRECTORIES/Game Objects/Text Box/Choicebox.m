//
//  Choicebox.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Choicebox.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "FontManager.h"
#import "BitmapFont.h"
#import "InputManager.h"
#import "Image.h"

@implementation Choicebox

- (void)dealloc {
    
    if (choiceStrings) {
        [choiceStrings release];
    }
    [super dealloc];
}

+ (void)choiceboxWithChoices:(NSArray *)aChoices {
    
    Choicebox *cb = [[Choicebox alloc] initChoiceboxWithChoices:aChoices];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:cb];
    [cb release];
}

- (id)initChoiceboxWithChoices:(NSArray *)aChoices
{
    self = [super init];
    if (self) {
        
        choices = [aChoices count];
        choiceStrings = [[NSMutableArray alloc] init];
        int rectHeight = choices * 40;
        for (int i = 0; i < [aChoices count]; i++) {
            [choiceStrings addObject:[aChoices objectAtIndex:i]];
            rects[i] = CGRectMake(100, 160 + ((float)rectHeight * 0.5) - 40 - (40 * i), 280, 40);
            NSLog(@"Rect is: (%f, %f, %f, %f)", rects[i].origin.x, rects[i].origin.y, rects[i].size.width, rects[i].size.height);
        }
        [sharedInputManager setState:kChoiceboxOnScreen];
        rect = CGRectMake(100, 160 - ((float)rectHeight * 0.5), 280, rectHeight);
        windowPixel.scale = Scale2fMake(280, rectHeight);
        active = YES;
    }
    
    return self;
}

- (void)render {
    
    if (active) {
        [windowPixel renderCenteredAtPoint:windowPixel.renderPoint];
        for (int i = 0; i < [choiceStrings count]; i++) {
            [textboxFont renderStringJustifiedInFrame:rects[i] justification:BitmapFontJustification_MiddleCentered text:[choiceStrings objectAtIndex:i]];
        }
    }
}

- (void)youWereTappedAt:(CGPoint)aLocation {
    
    NSLog(@"Choicebox was tapped.");
    for (int i = 0; i < [choiceStrings count]; i++) {
        if (CGRectContainsPoint(rects[i], aLocation)) {
            [sharedInputManager setState:kNoTouchesAllowed];
            [sharedGameController.currentScene choiceboxSelectionWas:i];
            return;
        }
    }
}

@end
