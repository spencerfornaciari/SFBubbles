//
//  SFViewController.m
//  SFBubbles
//
//  Created by Spencer Fornaciari on 11/2/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFViewController.h"

@interface SFViewController () <UIGestureRecognizerDelegate>

@end

@implementation SFViewController
{
    UIDynamicAnimator* _animator, *_animator2, *_animator3;
    UIGravityBehavior* _gravity, *_gravity2, *_gravity3;
    UICollisionBehavior* _collision, *_collison2, *_collison3;
    UIView *firstView;
    SFBubbleView *_testBubble;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect firstRect = CGRectMake(50, 50, 125, 136);
    self.bubbleOne = [[SFBubbleView alloc] initWithFrame:firstRect];
    self.bubbleOne.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.bubbleOne];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Creating gravity and collision for the bubbles
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:nil];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc] initWithItems:nil];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
    [_gravity addItem:self.bubbleOne];
    [_collision addItem:self.bubbleOne];

    //Creating bubbles and sub-bubbles
    [self createBubbles];

    // Do any additional setup after loading the view, typically from a nib

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"The subvies are currently: %@", self.view.subviews.description);

}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    //NSLog(@"There are currently: %d subviews", self.view.subviews.count);
    
    if (self.view.subviews.count < 3) {
        [self bubblesAllPopped];
    }
    
    [self startMyMotionDetect];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [self.motionManager stopAccelerometerUpdates];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Bubble methods

-(void)bubblesAllPopped
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Boo!" message:@"You've popped all the bubbles :-(" delegate:self cancelButtonTitle:@"Start over?" otherButtonTitles:nil, nil];
    [alertview show];
    [self createBubbles];
}

-(void)createBubbles
{
    for (int i = 0; i < 6; i++)
    {
        CGFloat xPos = arc4random_uniform(300);
        CGFloat yPos = arc4random_uniform(300);
        CGFloat width = 100;
        CGFloat height = 100;
        
        CGRect viewRect = CGRectMake (xPos, yPos, width, height);
        SFBubbleView *newView = [[SFBubbleView alloc] initWithFrame:viewRect];
        [self.view addSubview:newView];
        [_gravity addItem:newView];
        [_collision addItem:newView];
    }
}

//- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
//{
//    //Code to handle the gesture
//    [self bubblePop];
//    for (UIView *subview in [recognizer.self.view subviews]) {
//        [self.view addSubview:subview];
//        [_gravity addItem:subview];
//        [_collision addItem:subview];
//    }
////    [firstView removeFromSuperview];
//    [recognizer.self.view removeFromSuperview];
//    
//    NSLog(@"%@", recognizer);
//}

#pragma mark - Core Motion Code

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (void)startMyMotionDetect
{
    __block float stepMoveFactor = 15;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                             withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            
                            CGRect rect = self.bubbleOne.frame;
                            NSLog(@"%@", NSStringFromCGRect(rect));
                            
                            float movetoX = rect.origin.x + (data.acceleration.x * stepMoveFactor);
                            float maxX = self.view.frame.size.width - rect.size.width;
                            
                            float movetoY = (rect.origin.y + rect.size.height) - (data.acceleration.y * stepMoveFactor);
                            float maxY = self.view.frame.size.height;
                            
                            if ( movetoX > 0 && movetoX < maxX ) {rect.origin.x += (data.acceleration.x * stepMoveFactor);};
                            if ( movetoY > self.movingView.frame.size.height && movetoY < maxY ) {rect.origin.y -= (data.acceleration.y * stepMoveFactor);};
                            
                            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:
                             ^{
                                 self.bubbleOne.frame = rect;
                             }
                                             completion:nil
                             
                             ];
                            
                        });
     }
     ];
    
    
}


- (void)viewDidUnload {
    [self setMovingView:nil];
    [super viewDidUnload];
}

@end
