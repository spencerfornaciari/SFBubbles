//
//  SFBubbleView.m
//  SFBubbles
//
//  Created by Spencer Fornaciari on 11/3/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFBubbleView.h"

@implementation SFBubbleView
{
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGestureRecognizer];
       // UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        
        self.layer.cornerRadius = 25.f;
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        _gravity = [[UIGravityBehavior alloc] initWithItems:nil];
        [_animator addBehavior:_gravity];
        _collision = [[UICollisionBehavior alloc] initWithItems:nil];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        [_animator addBehavior:_collision];
        
        for (int i = 0; i<3; i++)
        {
            CGFloat xPos = i * 20 + 10;
            CGFloat yPos = i * 20 + 10;
            CGFloat width = 20;
            CGFloat height = 20;
            
            CGRect viewRect = CGRectMake (xPos, yPos, width, height);
            UIView *newView = [[UIView alloc] initWithFrame:viewRect];
            newView.backgroundColor = [UIColor getRandomColor];
            newView.layer.cornerRadius = 5.f;
            [self addSubview:newView];
            [_gravity addItem:newView];
            [_collision addItem:newView];
        }
    }
    
    self.backgroundColor = [UIColor getRandomColor];
    return self;
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
//    for (UIView *subview in [recognizer.self.view subviews]) {
//        [self.view addSubview:subview];
//        [_gravity addItem:subview];
//        [_collision addItem:subview];
//    }
    [recognizer.self.view removeFromSuperview];
    
    NSLog(@"%@", recognizer);
}

@end
