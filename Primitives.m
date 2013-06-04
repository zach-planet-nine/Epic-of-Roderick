//
//  Primitives.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Primitives.h"


@implementation Primitives

void drawRect(CGRect aRect) {
	
	GLfloat vertices[8];
	
	vertices[0] = aRect.origin.x;
	vertices[1] = aRect.origin.y;
	vertices[2] = aRect.origin.x + aRect.size.width;
	vertices[3] = aRect.origin.y;
	vertices[4] = aRect.origin.x + aRect.size.width;
	vertices[5] = aRect.origin.y + aRect.size.height;
	vertices[6] = aRect.origin.x;
	vertices[7] = aRect.origin.y + aRect.size.height;
	
	glDisableClientState(GL_COLOR_ARRAY);
	glDisable(GL_TEXTURE_2D);
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_LINE_LOOP, 0, 4);
	
	glEnableClientState(GL_COLOR_ARRAY);
	glEnable(GL_TEXTURE_2D);
}

void drawCircle(Circle aCircle, uint aSegments) {
	
	GLfloat vertices[aSegments*2];
	
	int vertexCount = 0;
	
	for (int segment = 0; segment < aSegments; segment++) {
		float theta = 2.0f * M_PI * (float)segment / (float)aSegments;
		
		float x = aCircle.radius * cosf(theta);
		float y = aCircle.radius * sinf(theta);
		
		vertices[vertexCount++] = x + aCircle.x;
		vertices[vertexCount++] = y + aCircle.y;
	}
	
	glDisableClientState(GL_COLOR_ARRAY);
	glDisable(GL_TEXTURE_2D);
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_LINE_LOOP, 0, 4);
	
	glEnableClientState(GL_COLOR_ARRAY);
	glEnable(GL_TEXTURE_2D);
}

@end
