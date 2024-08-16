//
//  ItemsMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ItemsMenu.h"
#import "GameController.h"
#import "Image.h"
#import "PackedSpriteSheet.h"
#import "BitmapFont.h"


@implementation ItemsMenu

- (void)dealloc {
	
	if (itemImages) {
		[itemImages release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		itemImages = [[NSMutableArray alloc] init];
		if (sharedGameController.healingLeaf) {
			Image *healingLeafImage = [menuSprites imageForKey:@"HealingLeaf30x30.png"];
			healingLeafImage.renderPoint = CGPointMake(50, 270);
			[itemImages addObject:healingLeafImage];
			[healingLeafImage release];
		}
		if (sharedGameController.antidote) {
			Image *antidoteImage = [menuSprites imageForKey:@"Antidote30x30.png"];
			antidoteImage.renderPoint = CGPointMake(100, 270);
			[itemImages addObject:antidoteImage];
			[antidoteImage release];
		}
		if (sharedGameController.bandage) {
			Image *bandageImage = [menuSprites imageForKey:@"Bandage30x30.png"];
			bandageImage.renderPoint = CGPointMake(150, 270);
			[itemImages addObject:bandageImage];
			[bandageImage release];
		}
		
		for (int i = 0; i < 10; i++) {
			itemRects[i] = CGRectMake(25 + (50 * i), 255 - (i / 4), 50, 50);
			//NSLog(@"i / 4 - %f", i / 4);
		}
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {}

- (void)render {
	
	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
	for (Image *image in itemImages) {
		[image renderCenteredAtPoint:image.renderPoint];
	}
	[menuFont renderStringAt:CGPointMake(80, 100) text:currentInformation];
}

- (void)youWereTappedAt:(CGPoint)aTapLocation {
	
	if (CGRectContainsPoint(itemRects[0], aTapLocation) && sharedGameController.healingLeaf) {
		currentInformation = @"Healing leaf heals 100 hp.";
	}
	if (CGRectContainsPoint(itemRects[1], aTapLocation) && sharedGameController.antidote) {
		currentInformation = @"Antidote heals poison.";
	}
	if (CGRectContainsPoint(itemRects[2], aTapLocation) && sharedGameController.bandage) {
		currentInformation = @"Bandages heal any bleeders you have.";
	}
}
	

@end
