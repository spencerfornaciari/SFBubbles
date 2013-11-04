//
//  SFAppDelegate.h
//  SFBubbles
//
//  Created by Spencer Fornaciari on 11/2/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@class SFViewController;

@interface SFAppDelegate : UIResponder <UIApplicationDelegate>
{
    
    CMMotionManager *motionManager;
}

@property (readonly) CMMotionManager *motionManager;

@property (strong, nonatomic) UIWindow *window;

@end
