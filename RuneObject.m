//
//  RuneObject.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RuneObject.h"
#import "GameController.h"
#import "Image.h"
#import "PackedSpriteSheet.h"


@implementation RuneObject

- (void)dealloc {
	
	[super dealloc];
}

- (id)initWithTypeOfRune:(int)aRune {
	
	if (self = [super init]) {
		NSString *filename = [NSString stringWithFormat:@"Rune%d.png", aRune];
		////NSLog(filename);
		//image = [[Image alloc] initWithImageNamed:filename filter:GL_LINEAR];
		image = [[GameController sharedGameController].teorPSS imageForKey:filename];
		image.renderPoint = CGPointMake(240, 160);
		image.scale = Scale2fMake(2.0, 2.0);
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	if (image.scale.x > 0.33) {
		image.scale = Scale2fMake(image.scale.x - (aDelta * 2), image.scale.y - (aDelta * 2));
	}
	if (image.scale.x < 0.33) {
		image.scale = Scale2fMake(0.33, 0.33);
	}
}

- (void)render {
	[image renderCenteredAtPoint:image.renderPoint];
}

- (void)setRenderPoint:(CGPoint)aRenderPoint {
	image.renderPoint = aRenderPoint;
}

@end
