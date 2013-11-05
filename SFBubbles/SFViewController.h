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

@interface SFViewController : UIViewController <SFBubbleViewDelegate>

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) IBOutlet SFBubbleView *movingView;
@property (strong, nonatomic) SFBubbleView *bubbleOne;
@property (strong, nonatomic) SFBubbleView *bubbleTwo;

@property (readonly) BOOL accelerometerAvailable;
@property (readonly) BOOL gyroAvailable;
@property (readonly) BOOL deviceMotionAvailable;

@property (strong, nonatomic) IBOutlet UIButton *createButton;

-(IBAction)createBubbleButton:(id)sender;

-(void)bubblesAllPopped;
-(void)createBubbles;

//- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer;

@end
