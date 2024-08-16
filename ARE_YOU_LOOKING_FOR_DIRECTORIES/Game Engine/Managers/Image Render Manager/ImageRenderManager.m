//
//  ImageRenderManager.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ImageRenderManager.h"
#import "Image.h"
#import "GameController.h"


@interface ImageRenderManager (Private)

- (void)copyImageDetails:(ImageDetails *)aImageDetails;

- (void)addToTextureList:(uint)aTextureName;
@end


@implementation ImageRenderManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ImageRenderManager);

- (void)dealloc {
	if (iva) {
		free(iva);
	}
	if (ivaIndices) {
		free(ivaIndices);
	}
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		iva = malloc(kMax_Images * sizeof(TexturedColoredQuad));
		
		ivaIndices = calloc(kMax_Images * 6, sizeof(GLushort));
		
		ivaIndex = 0;
		
		renderTextureCount = 0;
        
		memset(imageCountForTexture, 0, sizeof(NSUInteger) * kMax_Images);
	}
	return self;
}

- (void)addImageDetailsToRenderQueue:(ImageDetails *)aImageDetails {
	
	[self copyImageDetails:aImageDetails];
	
	[self addToTextureList:aImageDetails->textureName];
	
	ivaIndex++;
}

- (void)addTexturedColoredQuadToRenderQueue:(TexturedColoredQuad *)aTCQ texture:(uint)aTexture {
	memcpy((TexturedColoredQuad *)iva + ivaIndex, aTCQ, sizeof(TexturedColoredQuad));
	
	[self addToTextureList:aTexture];
	
	ivaIndex++;
}

- (void)renderImages {
	
	glVertexPointer(2, GL_FLOAT, sizeof(TexturedColoredVertex), &iva[0].geometryVertex);
	glTexCoordPointer(2, GL_FLOAT, sizeof(TexturedColoredVertex), &iva[0].textureVertex);
	glColorPointer(4, GL_FLOAT, sizeof(TexturedColoredVertex), &iva[0].vertexColor);
	
	
	for (NSInteger textureIndex = 0; textureIndex < renderTextureCount; textureIndex++) {
		
		glBindTexture(GL_TEXTURE_2D, texturesToRender[textureIndex]);
		
		int vertexCounter = 0;
		
		for (NSInteger imageIndex = 0; imageIndex < imageCountForTexture[texturesToRender[textureIndex]]; imageIndex++) {
			NSUInteger index = textureIndices[texturesToRender[textureIndex]][imageIndex] * 4;
			ivaIndices[vertexCounter++] = index;
			ivaIndices[vertexCounter++] = index + 2;
			ivaIndices[vertexCounter++] = index + 1;
			ivaIndices[vertexCounter++] = index + 1;
			ivaIndices[vertexCounter++] = index + 2;
			ivaIndices[vertexCounter++] = index + 3;
		}
		
		glDrawElements(GL_TRIANGLES, vertexCounter, GL_UNSIGNED_SHORT, ivaIndices);
		
		imageCountForTexture[texturesToRender[textureIndex]] = 0;
	}
	
	/*GLfloat quadVertices[8];
	 quadVertices[0] = 200.0f;
	 quadVertices[1] = 50.0f;
	 quadVertices[2] = 200.0f;
	 quadVertices[3] = 150.0f;	
	 quadVertices[4] = 350.0f;
	 quadVertices[5] = 50.0f;
	 quadVertices[6] = 350.0f;
	 quadVertices[7] = 150.0f;
	 
	 GLfloat texCoords[8];
	 texCoords[0] = 200.0f;
	 texCoords[1] = 50.0f;
	 texCoords[2] = 200.0f;
	 texCoords[3] = 150.0f;
	 texCoords[4] = 350.0f;
	 texCoords[5] = 50.0f;
	 texCoords[6] = 350.0f;
	 texCoords[7] = 150.0f;
	 
	 glVertexPointer(2, GL_FLOAT, 0, quadVertices);
	 glEnableClientState(GL_VERTEX_ARRAY);
	 glTexCoordPointer(2, GL_FLOAT, 0, texCoords);
	 glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	 
	 GLuint name;
	 CGImageRef image;
	 
	 NSString *knight = @"knight";
	 NSString *png = @"png";
	 NSString *path = [[NSBundle mainBundle] pathForResource:knight ofType:png];
	 UIImage *aImage = [UIImage imageWithContentsOfFile:path];
	 
	 image = [aImage CGImage];
	 CGContextRef context = nil;
	 GLubyte *data;
	 data = (GLubyte *) calloc(256 * 256 * 4, sizeof(GLubyte));
	 context = CGBitmapContextCreate(data, 256, 256, 8, 256 * 4, CGImageGetColorSpace(image), kCGImageAlphaPremultipliedLast);
	 //CGContextClearRect(context, CGRectMake(0, 0, 256, 256));
	 CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
	 CGContextRelease(context);
	 glGenTextures(1, &name);
	 glBindTexture(GL_TEXTURE_2D, name);
	 
	 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	 
	 glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 256, 256, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
	 
	 glEnable(GL_TEXTURE_2D);
	 
	 glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);*/
	
	renderTextureCount = 0;
	
	ivaIndex = 0;
}

@end

@implementation ImageRenderManager (Private)

- (void)copyImageDetails:(ImageDetails *)aImageDetails {
	
	if (ivaIndex + 1 > kMax_Images) {
		[self renderImages];
	}
	
	aImageDetails->texturedColoredQuadIVA = (TexturedColoredQuad *)iva + ivaIndex;
	
	memcpy(aImageDetails->texturedColoredQuadIVA, aImageDetails->texturedColoredQuad, sizeof(TexturedColoredQuad));
}

- (void)addToTextureList:(uint)aTextureName {
	
	BOOL textureFound = NO;
	for (int index=0; index < renderTextureCount; index++) {
		if (texturesToRender[index] == aTextureName) {
			textureFound = YES;
			break;
		}
	}
	
	if (!textureFound) {
		texturesToRender[renderTextureCount++] = aTextureName;
	}
	
	textureIndices[aTextureName][imageCountForTexture[aTextureName]] = ivaIndex;
	
	imageCountForTexture[aTextureName] += 1;
}


@end


