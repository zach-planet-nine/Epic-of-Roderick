//
//  Structures.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>

@class Image;

typedef struct {
    int stat;
    int threshold;
    int decider;
    int parameter;
    int ability;
} EnemyAI;

typedef struct {
	float x;
	float y;
} Scale2f;

typedef struct {
	float red;
	float green;
	float blue;
	float alpha;
} Color4f;

typedef struct {
	GLfloat x;
	GLfloat y;
} Vector2f;

typedef struct {
	CGPoint geometryVertex;
	CGPoint textureVertex;
} TexturedVertex;

typedef struct {
	TexturedVertex vertex1;
	TexturedVertex vertex2;
	TexturedVertex vertex3;
	TexturedVertex vertex4;
} TexturedQuad;

typedef struct {
	CGPoint geometryVertex;
	Color4f vertexColor;
	CGPoint textureVertex;
} TexturedColoredVertex;

typedef struct {
	TexturedColoredVertex vertex1;
	TexturedColoredVertex vertex2;
	TexturedColoredVertex vertex3;
	TexturedColoredVertex vertex4;
} TexturedColoredQuad;

typedef struct {
	TexturedColoredQuad *texturedColoredQuad;
	TexturedColoredQuad *texturedColoredQuadIVA;
	GLuint textureName;
} ImageDetails;

typedef struct {
	Image *image;
	float delay;
} AnimationFrame;

typedef struct {
	float x1, y1;
	float x2, y2;
	float x3, y3;
	float x4, y4;
} BoundingBoxTileQuad;

typedef struct {
	int x;
	int y;
} Position;

typedef struct {
	float x;
	float y;
	float radius;
} Circle;

