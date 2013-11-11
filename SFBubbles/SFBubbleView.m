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
    UICollisionBehavior *_collision;
    BOOL _dragging;
    CGPoint _startLocation, _offset;
    int _frameX, _frameY;
    float _frameWidth, _frameHeight;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

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
//        for (int i = 0; i<3; i++)
//        {
//            CGFloat xPos = i * 20 + 10;
//            CGFloat yPos = i * 20 + 10;
//            CGFloat width = 20;
//            CGFloat height = 20;
//            
//            CGRect viewRect = CGRectMake (xPos, yPos, width, height);
//            UIView *newView = [[UIView alloc] initWithFrame:viewRect];
//            newView.backgroundColor = [UIColor getRandomColor];
//            newView.layer.cornerRadius = 10.f;
//            [self addSubview:newView];
//            [self.bubGravity addItem:newView];
//            [self.bubCollision addItem:newView];
//            [self.bubItemBehaviour addItem:newView];
//            
//        }
    }
    
    //Define attributes of the bubble
    self.layer.cornerRadius = 37.5f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor getRandomColor];
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _dragging = YES;
    UITouch *touch = [[event allTouches] anyObject];
    _offset = [touch locationInView:self];
    _startLocation = [touch locationInView:self.superview];
    _frameWidth = self.frame.size.width;
    _frameHeight = self.frame.size.height;
    _frameX =  self.superview.frame.size.width;
    _frameY = self.superview.frame.size.height;
    NSLog(@"%f", touch.view.frame.size.width);
    NSLog(@"%d", touch.phase);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    //NSLog(@"X: %f %f", CGRectGetMinX(self.frame), CGRectGetMaxX(self.frame));
    //NSLog(@"Y: %f %f", CGRectGetMinY(self.frame), CGRectGetMaxY(self.frame));
    
    //    if (CGRectGetMinX(self.frame) < 0) {
    //        //        NSLog(@"%f", minX);
    //        //_dragging = NO;
    //        NSLog(@"Out of Bounds");
    //        //self.frame = CGRectMake((touchLocation.x-_offset.x)+1, touchLocation.y-_offset.y, _frameWidth, _frameHeight);
    //    }
    //    //NSLog(@"Out of Bounds");
    //
    //    //}
    //
    //    else if (CGRectGetMinY(self.frame) < 0) {
    //        //        NSLog(@"%f", minY);
    //        NSLog(@"Out of Bounds");
    //        _dragging = NO;
    //    }
    //    else if (CGRectGetMaxX(self.frame) > _frameX) {
    //        //        NSLog(@"%f", maxX);
    //        NSLog(@"Out of Bounds");
    //        //        _dragging = NO;
    //    }
    //    else if (CGRectGetMaxY(self.frame) > _frameY) {
    //        //        NSLog(@"%f", maxY);
    //        NSLog(@"Out of Bounds");
    //        //        _dragging = NO;
    //    }
    
    if (_dragging)
    {
        self.frame = CGRectMake(touchLocation.x-_offset.x, touchLocation.y-_offset.y, _frameWidth, _frameHeight);

    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    _dragging = NO;
    _frameWidth = 0.0;
    _frameHeight = 0.0;
}

@end
