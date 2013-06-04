//
//  DoomRoll.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DoomRoll.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "Projectile.h"
#import "Image.h"
#import "Textbox.h"


@implementation DoomRoll

- (void)dealloc {
	
	if (doom) {
		[doom release];
	}
	if (scythe) {
		[scythe release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
				
				
		doom = [[Image alloc] initWithImageNamed:@"Doom.png" filter:GL_LINEAR];
		doom.renderPoint = CGPointMake(160, 160);
		doom.color = Color4fMake(0, 0, 0, 0);
				
		//Remember this needs to be updated to the packed sprite sheet.
		scythe = [[Projectile alloc] initProjectileFrom:Vector2fMake(160, 160) 
													  to:Vector2fMake(480, 160) 
											   withImage:@"Scythe.png" lasting:0.4 
										  withStartAngle:35 
										   withStartSize:Scale2fMake(1, 1) 
											toFinishSize:Scale2fMake(1, 1) 
											   revolving:YES];
		scythe.isBoomerang = YES;
		stage = 0;
		active = YES;
		duration = 0.3;
		
	}
	return self;
}	

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				duration = 0.8;
				break;
			case 1:
				[self calculateEffect];
				duration = 0.3;
				stage = 2;
				break;
			case 2:
				stage = 3;
				active = NO;
				break;
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				doom.color = Color4fMake(doom.color.red + (aDelta * 4), doom.color.green + (aDelta * 4), doom.color.blue + (aDelta * 4), doom.color.alpha + (aDelta * 4));
				break;
			case 1:
				[scythe updateWithDelta:aDelta];
				break;
			case 2:
				doom.color = Color4fMake(doom.color.red - (aDelta * 4), doom.color.green - (aDelta * 4), doom.color.blue - (aDelta * 4), doom.color.alpha - (aDelta * 4));
				break;
			default:
				break;
		}
	}
	
}

- (void)render {
	
	if (active) {
		switch (stage) {
			case 0:
				[doom renderCenteredAtPoint:doom.renderPoint];
				break;
			case 1:
				[doom renderCenteredAtPoint:doom.renderPoint];
				[scythe render];
				break;
			case 2:
				[doom renderCenteredAtPoint:doom.renderPoint];
				break;
			default:
				break;
		}
	}
}

- (void)calculateEffect {
	
	for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
		if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
			int damage = enemy.hp / 2;
			[enemy flashColor:Color4fMake(0.7, 0, 0, 1)];
			[enemy youTookDamage:damage];
		}
	}
}

@end
