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
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];

        //Add Gravity and collision support for the bubble
        
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

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [recognizer.self.view removeFromSuperview];
}

@end
