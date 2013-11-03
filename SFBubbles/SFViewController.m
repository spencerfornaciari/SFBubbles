//
//  SFViewController.m
//  SFBubbles
//
//  Created by Spencer Fornaciari on 11/2/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFViewController.h"

@interface SFViewController ()

@end

@implementation SFViewController
{
    UIDynamicAnimator* _animator, *_animator2;
    UIGravityBehavior* _gravity, *_gravity2;
    UICollisionBehavior* _collision, *_collison2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect firstRect = CGRectMake(50, 50, 100, 100);
    UIView *firstView = [[UIView alloc] initWithFrame:firstRect];
    firstView.backgroundColor = [UIColor redColor];
    firstView.layer.cornerRadius = 10.f;
    [self.view addSubview:firstView];
    
    CGRect thirdRect = CGRectMake(110, 0, 100, 100);
    UIView *thirdView = [[UIView alloc] initWithFrame:thirdRect];
    thirdView.backgroundColor = [UIColor blueColor];
    thirdView.layer.cornerRadius = 10.f;
    [self.view addSubview:thirdView];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[firstView]];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc] initWithItems:@[firstView]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    [_gravity addItem:thirdView];
    [_collision addItem:thirdView];
    
    CGRect secondRect = CGRectMake(80, 0, 20, 20);
    UIView *secondView = [[UIView alloc] initWithFrame:secondRect];
    secondView.backgroundColor = [UIColor greenColor];
    [firstView addSubview:secondView];
    _animator2 = [[UIDynamicAnimator alloc] initWithReferenceView:firstView];
    _gravity2 = [[UIGravityBehavior alloc] initWithItems:@[secondView]];
    [_animator2 addBehavior:_gravity2];
    _collison2 = [[UICollisionBehavior alloc] initWithItems:@[secondView]];
    _collison2.translatesReferenceBoundsIntoBoundary = YES;
    [_animator2 addBehavior:_collison2];
    
    
    for (int i = 0; i<3; i++)
    {
        CGFloat superViewWidth = firstView.frame.size.width;
        CGFloat xPos = i * 10 + 10;
        CGFloat yPos = 0;
        CGFloat width = superViewWidth/6;
        CGFloat height = superViewWidth/6;
        
        CGRect viewRect = CGRectMake (xPos, yPos, width, height);
        UIView *newView = [[UIView alloc] initWithFrame:viewRect];
        newView.backgroundColor = [UIColor grayColor];
        [firstView addSubview:newView];
        [_gravity2 addItem:newView];
        [_collison2 addItem:newView];
    }


    
    
//    for (int i = 0; i < 5; i++)
//    {
//        CGFloat superViewWidth = self.view.frame.size.width;
//        CGFloat xPos = superViewWidth/5*i;
//        CGFloat yPos = 20.0;
//        CGFloat width = superViewWidth/5;
//        CGFloat height = superViewWidth/5;
//        
//        CGRect viewRect = CGRectMake (xPos, yPos, width, height);
//        
//        UIView *newView = [[UIView alloc] initWithFrame:viewRect];
//        newView.backgroundColor = [UIColor redColor];
//        [self.view addSubview:newView];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
