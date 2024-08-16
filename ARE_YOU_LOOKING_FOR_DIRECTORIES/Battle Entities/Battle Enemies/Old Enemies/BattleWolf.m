//
//  BattleWolf.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleWolf.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"
#import "Image.h"

@implementation BattleWolf

- (void)dealloc {
	
    if (defaultImage) {
        [defaultImage release];
    }
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[[SpriteSheet spriteSheetForImage:[[[PackedSpriteSheet alloc] initWithImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" filter:GL_LINEAR] imageForKey:@"wolf_spritesheet.png"] sheetKey:@"wolf_spritesheet.png" spriteSize:CGSizeMake(80, 40) spacing:10 margin:0] spriteImageAtCoords:CGPointMake(0, 0)] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 3;
		hp = 200;
		maxHP = 30;
		essence = 0;
		maxEssence = 0;
		strength = 2;
		agility = 7;
		stamina = 4;
		dexterity = 6;
		power = 0;
		luck = 0;
		battleTimer = 0.0;
		experience = 40;
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}
@end
