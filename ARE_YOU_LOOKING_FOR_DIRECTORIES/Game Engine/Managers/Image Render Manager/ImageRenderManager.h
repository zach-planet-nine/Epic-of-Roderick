//
//  ImageRenderManager.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES1/gl.h>
#import "SynthesizeSingleton.h"
#import "Structures.h"
#import "Global.h"

@class Image;

#define kMax_Images 350
#define kMax_Textures 30

@interface ImageRenderManager : NSObject {
	
	TexturedColoredVertex *iva;
	
	GLushort *ivaIndices;
	
	NSUInteger textureIndices[kMax_Textures][kMax_Images];
	
	NSUInteger texturesToRender[kMax_Textures];
	
	NSUInteger imageCountForTexture[kMax_Images];
	
	NSUInteger renderTextureCount;
	GLushort ivaIndex;
}

+ (ImageRenderManager *)sharedImageRenderManager;

- (void)addImageDetailsToRenderQueue:(ImageDetails *)aImageDetails;

- (void)addTexturedColoredQuadToRenderQueue:(TexturedColoredQuad *)aTCQ texture:(uint)aTexture;

- (void)renderImages;

@end
