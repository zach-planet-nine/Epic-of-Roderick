//
//  TEORWorldMapTestAppDelegate.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 5/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface TEORWorldMapTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;


@end

