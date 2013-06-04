//
//  GreenRobo.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GreenRobo.h"
#import "Image.h"
#import "SpriteSheet.h"
#import "Animation.h"


@implementation GreenRobo

- (id)init {
	
	if (self = [super init]) {
		SpriteSheet *roboSheet = [[SpriteSheet alloc] initWithImageNamed:@"RoboSheet.png" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0 imageFilter:GL_LINEAR];
		
		float delay = 0.3;
		
		for (int i = 0; i < 3; i++) {
			Image *leftImage = [roboSheet spriteImageAtCoords:CGPointMake(4, 17 + i)];
			Image *rightImage = [roboSheet spriteImageAtCoords:CGPointMake(6, 17 + i)];
			Image *upImage = [roboSheet spriteImageAtCoords:CGPointMake(5, 17 + i)];
			Image *downImage = [roboSheet spriteImageAtCoords:CGPointMake(7, 17 + i)];
			
			leftImage.color = rightImage.color = upImage.color = downImage.color = Color4fMake(0, 1, 0, 1);
			
			[leftAnimation addFrameWithImage:leftImage delay:0.3];
			[rightAnimation addFrameWithImage:rightImage delay:0.3];
			[upAnimation addFrameWithImage:upImage delay:0.3];
			[downAnimation addFrameWithImage:downImage delay:0.3];
			
		}
		
		Image *leftImage = [roboSheet spriteImageAtCoords:CGPointMake(4, 18)];
		Image *rightImage = [roboSheet spriteImageAtCoords:CGPointMake(6, 18)];
		Image *upImage = [roboSheet spriteImageAtCoords:CGPointMake(5, 18)];
		Image *downImage = [roboSheet spriteImageAtCoords:CGPointMake(7, 18)];
		
		leftImage.color = rightImage.color = upImage.color = downImage.color = Color4fMake(0, 1, 0, 1);
		
		[leftAnimation addFrameWithImage:leftImage delay:0.3];
		[rightAnimation addFrameWithImage:rightImage delay:0.3];
		[upAnimation addFrameWithImage:upImage delay:0.3];
		[downAnimation addFrameWithImage:downImage delay:0.3];
		
	}
	return self;
}
	
																  
	

@end
