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
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UICollisionBehavior* _collision;
    UIDynamicItemBehavior *_itemBehaviour;
    NSMutableArray *_bubblesArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bubblesArray = [[NSMutableArray alloc] init];
    
//    CGRect firstRect = CGRectMake(50, 50, 100, 100);
//    self.bubbleOne = [[SFBubbleView alloc] initWithFrame:firstRect];
//    self.bubbleOne.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:self.bubbleOne];
//    [_bubblesArray addObject:self.bubbleOne];
//
//    CGRect secondRect = CGRectMake(0, 0, 50, 50);
//    self.bubbleTwo = [[SFBubbleView alloc] initWithFrame:secondRect];
//    self.bubbleTwo.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:self.bubbleTwo];
//    [_bubblesArray addObject:self.bubbleTwo];
    

//    [_gravity addItem:self.bubbleTwo];
//    [_collision addItem:self.bubbleTwo];


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Creating gravity and collision for the bubbles
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:nil];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc] initWithItems:nil];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
    //_itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:nil];
    //_itemBehaviour.elasticity = 1.1;
    //[_animator addBehavior:_itemBehaviour];
    
//    [_gravity addItem:self.bubbleOne];
//    [_collision addItem:self.bubbleOne];
    
    //Creating bubbles and sub-bubbles
    [self createBubbles];
    
//    NSLog(@"There are currently %d subviews", self.view.subviews.count);
//    NSLog(@"The subviews are currently: %@", self.view.subviews.description);
//    NSLog(@"The array has %d subviews", _bubblesArray.count);
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    //NSLog(@"There are currently: %d subviews", self.view.subviews.count);
    
//    if (self.view.subviews.count == 0) {
//        [self bubblesAllPopped];
//    }
    
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


//Original creator of bubbles
-(void)createBubbles
{
    for (int i = 0; i < 5; i++)
    {
        CGFloat xPos = arc4random_uniform(260);
        CGFloat yPos = arc4random_uniform(410);
        CGFloat width = 75;
        CGFloat height = 75;
        
        CGRect viewRect = CGRectMake (xPos, yPos, width, height);
        SFBubbleView *newView = [[SFBubbleView alloc] initWithFrame:viewRect];
        [_bubblesArray addObject:newView];
        [self.view addSubview:newView];
        [_gravity addItem:newView];
        [_collision addItem:newView];
        //[_itemBehaviour addItem:newView];
    }
}

//Changes the shape of the bubbles/sub-bubbles
-(IBAction)createBubbleButton:(id)sender
{
    for (SFBubbleView *view in _bubblesArray)
    {
        CABasicAnimation *changeShape = [CABasicAnimation animationWithKeyPath:@"shape"];
        changeShape.fromValue = [NSValue valueWithCGRect:view.layer.bounds];
        changeShape.toValue = [NSValue valueWithCGRect:CGRectMake(50, 50, 50, 50)];
        changeShape.duration = 4.0;
        view.layer.cornerRadius = 0;
        view.backgroundColor = [UIColor getRandomColor];
        [view.layer addAnimation:changeShape forKey:@"shape"];
        view.layer.bounds = CGRectMake(50, 50, 50, 50);
        
        //Bubbles location doesn't remain within the bounds of the outer bubble
        for (UIView *bubView in view.subviews) {
            CABasicAnimation *changeShape = [CABasicAnimation animationWithKeyPath:@"shape"];
            changeShape.fromValue = [NSValue valueWithCGRect:bubView.layer.bounds];
            changeShape.toValue = [NSValue valueWithCGRect:CGRectMake(10, 10, 10, 10)];
            changeShape.duration = 4.0;
            bubView.layer.cornerRadius = 0;
            bubView.backgroundColor = [UIColor getRandomColor];
            [bubView.layer addAnimation:changeShape forKey:@"shape"];
            bubView.layer.bounds = CGRectMake(10, 10, 10, 10);
        }
    }
}

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
                            //NSLog(@"%@", NSStringFromCGRect(rect));
                            
                            float movetoX = rect.origin.x + (data.acceleration.x * stepMoveFactor);
                            float maxX = self.view.frame.size.width - rect.size.width;
                            
                            float movetoY = (rect.origin.y + rect.size.height) - (data.acceleration.y * stepMoveFactor);
                            float maxY = self.view.frame.size.height;
                            
                            if ( movetoX > 0 && movetoX < maxX ) {rect.origin.x += (data.acceleration.x * stepMoveFactor);};
                            if ( movetoY > self.movingView.frame.size.height && movetoY < maxY ) {rect.origin.y -= (data.acceleration.y * stepMoveFactor);};
                            
                            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:
                             ^{
                                 self.bubbleOne.frame = rect;
                                 //self.bubbleTwo.frame = rect;
                                 
                                 
                             }
                                             completion:nil
                             
                             ];
                            
                        });
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            
                            CGRect rect = self.bubbleTwo.frame;
                            
                            float movetoX = rect.origin.x + (data.acceleration.x * stepMoveFactor);
                            float maxX = self.view.frame.size.width - rect.size.width;
                            
                            float movetoY = (rect.origin.y + rect.size.height) - (data.acceleration.y * stepMoveFactor);
                            float maxY = self.view.frame.size.height;
                            
                            if ( movetoX > 0 && movetoX < maxX ) {rect.origin.x += (data.acceleration.x * stepMoveFactor);};
                            if ( movetoY > self.movingView.frame.size.height && movetoY < maxY ) {rect.origin.y -= (data.acceleration.y * stepMoveFactor);};
                            
                            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:
                             ^{
                                 self.bubbleTwo.frame = rect;
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
