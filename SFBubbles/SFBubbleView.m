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
    BOOL _dragging;
    CGPoint _startLocation, _offset;
    int _frameX, _frameY;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _frameX = 75;
        _frameY = 75;
        //UITouch *bubbleTouch = [[UITouch alloc] init];
        //NSLog(@"%@", bubbleTouch);
        //bubbleTouch.
        
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
    //NSLog(@"%f %f", _startLocation.x, _startLocation.y);
    CGRectGetMaxX(self.frame);
//    NSLog(@"X: %f %f", CGRectGetMinX(self.frame), CGRectGetMaxX(self.frame));
//    NSLog(@"Y: %f %f", CGRectGetMinY(self.frame), CGRectGetMaxY(self.frame));
    //NSLog(@"%f %f", self.window.frame.size.width, self.window.frame.size.height);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    //NSLog(@"Touches Moved");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    NSLog(@"X: %f %f", CGRectGetMinX(self.frame), CGRectGetMaxX(self.frame));
    NSLog(@"Y: %f %f", CGRectGetMinY(self.frame), CGRectGetMaxY(self.frame));
    float minX = CGRectGetMinX(self.frame);
    float maxX = CGRectGetMaxX(self.frame);
    float minY = CGRectGetMinY(self.frame);
    float maxY = CGRectGetMaxY(self.frame);
    
    NSLog(@"%@", self.description);

    
    
   // NSLog(@"X: %f %f", CGRectGetMinX(self.frame), CGRectGetMaxX(self.frame));
   // NSLog(@"Y: %f %f", CGRectGetMinY(self.frame), CGRectGetMaxY(self.frame));
   // NSLog(@"%f %f", self.window.frame.size.width, self.window.frame.size.height);
    //CGPoint touchCenter = self.center;
    
   ///if (self.frame.origin.x > 0 && touchLocation.x < (self.superview.frame.size.width - self.frame.size.width) && self.frame.origin.y > 0 && touchLocation.y < (self.superview.frame.size.height - self.frame.size.height))
    //{
       // self.frame = CGRectOffset(self.frame, touchLocation.x, touchLocation.y);
        
        //self.frame = CGRectMake(floatNewX, floatNewY, self.frame.size.width,self.frame.size.height);
        //[UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    
   //if (CGRectMinXEdge >= 0 && CGRectMaxXEdge <= self.window.frame.size.width)
   //{
    
    
    if (maxX <= 360)
    {
       self.frame = CGRectMake(touchLocation.x-_offset.x, touchLocation.y-_offset.y, 75, 75);
       //NSLog(@"%f %f", CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
       // maxX = CGRectGetMaxX(self.frame);
       //NSLog(@"%d, %d", CGRectMinXEdge, CGRectMaxXEdge);
    }
    //{
        //self.frame = CGRectMake(touchLocation.x-_offset.x, touchLocation.y-_offset.y, 75, 75);
       // NSLog(@"%f, %f", touchLocation.x, touchLocation.y);
        
    //}
       // NSLog(@"Origin: %f, %f", self.frame.origin.x, self.frame.origin.y);
       // NSLog(@"%f, %f", floatNewX, floatNewY);
       // self.frame = CGRectMake(touchLocation.x, touchLocation.y, _frameX, _frameY);
        //[UIView commitAnimations];
    //}
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    _dragging = NO;
}

@end
