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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:nil];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc] initWithItems:nil];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];

    
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
    

//    CGRect firstRect = CGRectMake(50, 50, 100, 100);
//    firstView = [[UIView alloc] initWithFrame:firstRect];
//    firstView.backgroundColor = [UIColor redColor];
//    firstView.layer.cornerRadius = 25.f;
//    [self.view addSubview:firstView];
//    
//    CGRect newRect = CGRectMake(220, 10, 100, 100);
//    self.bubbleThree = [[SFBubbleView alloc] initWithFrame:newRect];
//    [self.view addSubview:self.bubbleThree];
//    
//    [self.bubbleThree addGestureRecognizer:tapGestureRecognizer];
//    
//    
//    [firstView addGestureRecognizer:tapGestureRecognizer];
//    tapGestureRecognizer.numberOfTapsRequired = 1;
//    tapGestureRecognizer.delegate = self;
//    
//    CGRect thirdRect = CGRectMake(110, 0, 100, 100);
//    UIView *thirdView = [[UIView alloc] initWithFrame:thirdRect];
//    thirdView.backgroundColor = [UIColor blueColor];
//    thirdView.layer.cornerRadius = 25.f;
//    [self.view addSubview:thirdView];
    
//    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//    _gravity = [[UIGravityBehavior alloc] initWithItems:@[firstView, self.bubbleOne, self.bubbleTwo, self.bubbleFour, self.movingView, self.bubbleThree]];
//    [_animator addBehavior:_gravity];
//    _collision = [[UICollisionBehavior alloc] initWithItems:@[firstView, self.bubbleOne, self.bubbleTwo, self.bubbleFour, self.movingView, self.bubbleThree]];
//    _collision.translatesReferenceBoundsIntoBoundary = YES;
//    [_animator addBehavior:_collision];
//    [_gravity addItem:thirdView];
//    [_collision addItem:thirdView];
    
//    CGRect secondRect = CGRectMake(80, 0, 20, 20);
//    UIView *secondView = [[UIView alloc] initWithFrame:secondRect];
//    secondView.backgroundColor = [UIColor greenColor];
//    [firstView addSubview:secondView];
//    _animator2 = [[UIDynamicAnimator alloc] initWithReferenceView:firstView];
//    _gravity2 = [[UIGravityBehavior alloc] initWithItems:@[secondView]];
//    [_animator2 addBehavior:_gravity2];
//    _collison2 = [[UICollisionBehavior alloc] initWithItems:@[secondView]];
//    _collison2.translatesReferenceBoundsIntoBoundary = YES;
//    [_animator2 addBehavior:_collison2];
//    
//    
//    for (int i = 0; i<3; i++)
//    {
//        CGFloat xPos = i * 10 + 10;
//        CGFloat yPos = arc4random_uniform(100);
//        CGFloat width = 20;
//        CGFloat height = 20;
//        
//        CGRect viewRect = CGRectMake (xPos, yPos, width, height);
//        UIView *newView = [[UIView alloc] initWithFrame:viewRect];
//        newView.backgroundColor = [UIColor getRandomColor];
//        [firstView addSubview:newView];
//        [_gravity2 addItem:newView];
//        [_collison2 addItem:newView];
//    }
//        
//    
//    CGRect fourthRect = CGRectMake(80, 0, 20, 20);
//    UIView *fourthView = [[UIView alloc] initWithFrame:fourthRect];
//    fourthView.backgroundColor = [UIColor orangeColor];
//    [thirdView addSubview:fourthView];
//    _animator3 = [[UIDynamicAnimator alloc] initWithReferenceView:thirdView];
//    _gravity3 = [[UIGravityBehavior alloc] initWithItems:@[fourthView]];
//    [_animator3 addBehavior:_gravity3];
//    _collison3 = [[UICollisionBehavior alloc] initWithItems:@[fourthView]];
//    _collison3.translatesReferenceBoundsIntoBoundary = YES;
//    [_animator3 addBehavior:_collison3];
//    
//    for (int i = 0; i<3; i++)
//    {
//        CGFloat xPos = i * 10 + 10;
//        CGFloat yPos = arc4random_uniform(100);
//        CGFloat width = 20;
//        CGFloat height = 20;
//        
//        CGRect viewRect = CGRectMake (xPos, yPos, width, height);
//        UIView *newView = [[UIView alloc] initWithFrame:viewRect];
//        newView.backgroundColor = [UIColor getRandomColor];
//        [thirdView addSubview:newView];
//        [_gravity3 addItem:newView];
//        [_collison3 addItem:newView];
//        
//    }
    
    // Do any additional setup after loading the view, typically from a nib

}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
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

-(void)bubblePop
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Hurray!" message:@"You've popped a bubble" delegate:self cancelButtonTitle:@"Do it Again?" otherButtonTitles:nil, nil];
    [alertview show];
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    //Code to handle the gesture
    [self bubblePop];
    for (UIView *subview in [firstView subviews]) {
        [self.view addSubview:subview];
        [_gravity addItem:subview];
        [_collision addItem:subview];
    }
    [firstView removeFromSuperview];
}

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
    
    [self.motionManager
     startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
     withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            
                            CGRect rect = self.movingView.frame;
                            //CGRect rect = firstView.frame;
                            
                            float movetoX = rect.origin.x + (data.acceleration.x * stepMoveFactor);
                            float maxX = self.view.frame.size.width - rect.size.width;
                            
                            float movetoY = (rect.origin.y + rect.size.height)
                            - (data.acceleration.y * stepMoveFactor);
                            
                            float maxY = self.view.frame.size.height;
                            
                            if ( movetoX > 0 && movetoX < maxX ) {
                                rect.origin.x += (data.acceleration.x * stepMoveFactor);
                            };
                            
                            if ( movetoY > 0 && movetoY < maxY ) {
                                rect.origin.y -= (data.acceleration.y * stepMoveFactor);
                            };
                            
                            [UIView animateWithDuration:0 delay:0
                                                options:UIViewAnimationOptionCurveEaseInOut
                                             animations:
                             ^{
                                 //self.movingView.frame = rect;
                                // self.bubbleOne.frame = rect;
                                 //firstView.frame = rect;
                             }
                                             completion:nil
                             ];
                            
                        }
                        );
     }
     ];
    
}

@end
