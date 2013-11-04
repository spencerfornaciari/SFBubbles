//
//  SFViewController.h
//  SFBubbles
//
//  Created by Spencer Fornaciari on 11/2/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "SFBubbleView.h"
#import "UIColor+ColorAddons.h"

@interface SFViewController : UIViewController

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) IBOutlet UIView *movingView;
@property (strong, nonatomic) IBOutlet UIView *bubbleOne;
@property (strong, nonatomic) IBOutlet UIView *bubbleTwo;
@property (strong, nonatomic) IBOutlet UIView *bubbleFour;

@property (strong, nonatomic) SFBubbleView *bubbleThree;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *bubbleCollection;

-(void)bubblePop;

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer;

@end
