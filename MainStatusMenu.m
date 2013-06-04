//
//  MainStatusMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MainStatusMenu.h"
#import "Character.h"
#import "Animation.h"
#import "PackedSpriteSheet.h"
#import "Image.h" 
#import "GameController.h"
#import "BitmapFont.h"
#import "MenuSystem.h"

@implementation MainStatusMenu

@synthesize currentTopCharacter;

- (void)dealloc {
	
	if (iconAnimations) {
		[iconAnimations release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		character1Rect = CGRectMake(10, 189, 440, 94);
		character2Rect = CGRectMake(10, 95, 440, 94);
		character3Rect = CGRectMake(10, 0, 440, 94);
		
		
		Image *runeIcon = [[[menuSprites imageForKey:@"RuneIcon28x28.png"] imageDuplicate] retain];
		Image *runeIconSelected = [[[menuSprites imageForKey:@"RuneIconSelected28x28.png"] imageDuplicate] retain];
		Image *equipmentIcon = [[[menuSprites imageForKey:@"EquipmentIcon28x28.png"] imageDuplicate] retain];
		Image *equipmentIconSelected = [[[menuSprites imageForKey:@"EquipmentIconSelected28x28.png"] imageDuplicate] retain];
		Image *skillsIcon = [[[menuSprites imageForKey:@"SkillsIcon28x28.png"] imageDuplicate] retain];
		Image *skillsIconSelected = [[[menuSprites imageForKey:@"SkillsIconSelected28x28.png"] imageDuplicate] retain];
        
        roderick = [sharedGameController.characters objectForKey:@"Roderick"];
		if ([roderick.knownRunes count] > 0) {
            for (int i = 0; i < MIN([[GameController sharedGameController].party count] * 3, 9); i++) {
                iconRects[i] = CGRectMake(439, 248 - (i * 31), 30, 30);
                //NSLog(@"Rect is: (%f, %f, %f, %f).", iconRects[i].origin.x, iconRects[i].origin.y, iconRects[i].size.width, iconRects[i].size.height);
            }
        }
        
		iconAnimations = [[NSMutableArray alloc] initWithCapacity:9];
		
		for (int i = 0; i < MIN([[GameController sharedGameController].party count], 3); i++) {
			Animation *runeIconAnimation = [[Animation alloc] init];
			Animation *equipmentIconAnimation = [[Animation alloc] init];
			Animation *skillsIconAnimation = [[Animation alloc] init];
			
			[runeIconAnimation addFrameWithImage:runeIcon delay:0.2];
			[runeIconAnimation addFrameWithImage:runeIconSelected delay:0.2];
			[equipmentIconAnimation addFrameWithImage:equipmentIcon delay:0.2];
			[equipmentIconAnimation addFrameWithImage:equipmentIconSelected delay:0.2];
			[skillsIconAnimation addFrameWithImage:skillsIcon delay:0.2];
			[skillsIconAnimation addFrameWithImage:skillsIconSelected delay:0.2];
			runeIconAnimation.renderPoint = CGPointMake(455, 264 - (93 * i));
			equipmentIconAnimation.renderPoint = CGPointMake(455, 233 - (93 * i));
			skillsIconAnimation.renderPoint = CGPointMake(455, 202 - (93 * i));
			runeIconAnimation.state = equipmentIconAnimation.state = skillsIconAnimation.state = kAnimationState_Stopped;
			runeIconAnimation.type = equipmentIconAnimation.type = skillsIconAnimation.type = kAnimationType_Repeating;
			runeIconAnimation.bounceFrame = equipmentIconAnimation.bounceFrame = skillsIconAnimation.bounceFrame = 0;
			[iconAnimations addObject:runeIconAnimation];
			[iconAnimations addObject:equipmentIconAnimation];
			[iconAnimations addObject:skillsIconAnimation];
			[runeIconAnimation release];
			[equipmentIconAnimation release];
			[skillsIconAnimation release];
		}
		currentTopCharacter = 0;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	for (Animation *animation in iconAnimations) {
		[animation updateWithDelta:aDelta];
	}
}

- (void)render {
	
	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
    if ([roderick.knownRunes count] > 0) {
        for (Animation *animation in iconAnimations) {
            [animation renderCenteredAtPoint:animation.renderPoint];
        }
    }
		for (int i = currentTopCharacter; i < MIN((currentTopCharacter + 3), [[GameController sharedGameController].party count]); i++) {
		Character *charac = [currentMenu.characters objectAtIndex:i];
		[charac.characterImage renderCenteredAtPoint:CGPointMake(80, 233 - (94 * (i - currentTopCharacter)))];
		[menuFont renderStringAt:CGPointMake(120, 263 - (94 * (i - currentTopCharacter))) text:charac.name];
		[menuFont renderStringAt:CGPointMake(120, 233 - (94 * (i - currentTopCharacter))) text:[NSString stringWithFormat:@"HP: %d/%d", charac.hp, charac.maxHP]];
		[menuFont renderStringAt:CGPointMake(120, 203 - (94 * (i - currentTopCharacter))) text:[NSString stringWithFormat:@"Essence: %d/%d", charac.essence, charac.maxEssence]];
		[menuFont renderStringAt:CGPointMake(240, 263 - (94 * (i - currentTopCharacter))) text:@"Status:"]; // Put status icons after this.
		[menuFont renderStringAt:CGPointMake(240, 233 - (94 * (i - currentTopCharacter))) text:[NSString stringWithFormat:@"Level: %d", charac.level]];
		[menuFont renderStringAt:CGPointMake(240, 203 - (94 * (i - currentTopCharacter))) text:[NSString stringWithFormat:@"Experience: %d/%d", charac.experience, charac.toNextLevel]];
	}
	
	[upArrow renderCenteredAtPoint:CGPointMake(260, 10)];
	[downArrow renderCenteredAtPoint:CGPointMake(220, 10)];
}

- (void)youWereTappedAt:(CGPoint)aTapLocation {
	
	//NSLog(@"Tap got to current menu.");
	
	if (CGRectContainsPoint(CGRectMake(200, 0, 40, 40), aTapLocation)) {
		if (currentTopCharacter < ([[GameController sharedGameController].party count] - 3) && [[GameController sharedGameController].party count] > 3) {
			currentTopCharacter++;
		}
	}
	if (CGRectContainsPoint(CGRectMake(241, 0, 40, 40), aTapLocation)) {
		if (currentTopCharacter > 0) {
			currentTopCharacter--;
		}
	}
	
	for (int i = 0; i < MIN([[GameController sharedGameController].party count], 3); i++) {
        if (CGRectContainsPoint(CGRectMake(10, 189 - (95 * i), 100, 95), aTapLocation)) {
            [currentMenu loadStatusMenuForCharacter:(currentTopCharacter + i)];
        }
		if (CGRectContainsPoint(iconRects[i * 3], aTapLocation)) {
			[currentMenu loadRuneMenuForCharacter:(currentTopCharacter + i)];
		} else if (CGRectContainsPoint(iconRects[(i * 3) + 1], aTapLocation)) {
			[currentMenu loadEquipmentMenuForCharacter:(currentTopCharacter + i)];
		} 
		else if (CGRectContainsPoint(iconRects[(i * 3) + 2], aTapLocation)) {
			[currentMenu loadSkillsMenuForCharacter:(currentTopCharacter + i)];
		}
	}/*
	if (CGRectContainsPoint(CGRectMake(15, 290, 91, 30), aTouchLocation)) {
		mainColor = Color4fMake(1, 1, 1, 1);
		[currentMenu loadMainMenu];
	} else if (CGRectContainsPoint(CGRectMake(107, 290, 91, 30), aTouchLocation)) {
		itemsColor = Color4fMake(1, 1, 0, 1);
		[currentMenu loadItemsMenu];
	} else if (CGRectContainsPoint(CGRectMake(199, 290, 91, 30), aTouchLocation)) {
		partyColor = Color4fMake(1, 1, 0, 1);
		[currentMenu loadPartyMenu];
	} else if (CGRectContainsPoint(CGRectMake(291, 290, 91, 30), aTouchLocation)) {
		systemColor = Color4fMake(1, 1, 0, 1);
		[currentMenu loadSystemMenu];
	} else if (CGRectContainsPoint(CGRectMake(383, 290, 91, 30), aTouchLocation)) {
		settingsColor = Color4fMake(1, 1, 0, 1);
		[currentMenu loadSettingsMenu];*/
}

- (void)fingerIsDownAt:(CGPoint)aTouchLocation {
	
	 for (int i = 0; i < MIN([[GameController sharedGameController].party count] * 3, 9); i++) {
		if (CGRectContainsPoint(iconRects[i], aTouchLocation)) {
			Animation *animation = [iconAnimations objectAtIndex:i];
			animation.state = kAnimationState_Running;
			//NSLog(@"Animation is alive? (%f, %f).", animation.renderPoint.x, animation.renderPoint.y);
		} else {
			Animation *animation = [iconAnimations objectAtIndex:i];
			animation.state = kAnimationState_Stopped;
		}

	}
}


	
	

@end
