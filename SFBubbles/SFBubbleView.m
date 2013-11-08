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
//    UIDynamicAnimator *_animator;
//    UIGravityBehavior *_gravity;
//    UICollisionBehavior *_collision;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Create tap responder
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGestureRecognizer];
        

        //Add Gravity and collision support for the bubble
//        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
//        _gravity = [[UIGravityBehavior alloc] initWithItems:nil];
//        [_animator addBehavior:_gravity];
//        _collision = [[UICollisionBehavior alloc] initWithItems:nil];
//        _collision.translatesReferenceBoundsIntoBoundary = YES;
//        [_animator addBehavior:_collision];
        
        self.bubAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.bubGravity = [[UIGravityBehavior alloc] initWithItems:nil];
        [self.bubAnimator addBehavior:self.bubGravity];
        self.bubCollision = [[UICollisionBehavior alloc] initWithItems:nil];
        self.bubCollision.translatesReferenceBoundsIntoBoundary = YES;
        [self.bubAnimator addBehavior:self.bubCollision];
        self.bubItemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:nil];
        self.bubItemBehaviour.elasticity = 1.0;
        [self.bubAnimator addBehavior:self.bubItemBehaviour];
        
        
        //Create sub-bubbles
        for (int i = 0; i<3; i++)
        {
            CGFloat xPos = i * 20 + 10;
            CGFloat yPos = i * 20 + 10;
            CGFloat width = 20;
            CGFloat height = 20;
            
            CGRect viewRect = CGRectMake (xPos, yPos, width, height);
            UIView *newView = [[UIView alloc] initWithFrame:viewRect];
            newView.backgroundColor = [UIColor getRandomColor];
            newView.layer.cornerRadius = 10.f;
            [self addSubview:newView];
            [self.bubGravity addItem:newView];
            [self.bubCollision addItem:newView];
            [self.bubItemBehaviour addItem:newView];
            
        }
    }
    
    //Define attributes of the bubble
    self.layer.cornerRadius = 37.f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor getRandomColor];
    return self;
}



//Create a pop up alert when the bubbles are popped
-(void)bubblePop
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Hurray!" message:@"You've popped a bubble" delegate:self cancelButtonTitle:@"Do it Again?" otherButtonTitles:nil, nil];
    [alertview show];
}

//Call bubble pop alert message and remove it from the sub-view
-(void)handleTapFrom:(UITapGestureRecognizer *)recognizer
{
    //Code to handle the gesture
    [self bubblePop];
//    for (UIView *subview in [recognizer.self.view subviews]) {
//        [recognizer.self.view.superview addSubview:subview];
//        [_gravity addItem:subview];
//        [_collision addItem:subview];
        
//    }
    [recognizer.self.view removeFromSuperview];
    
   // NSLog(@"%@", recognizer);
}

@end
