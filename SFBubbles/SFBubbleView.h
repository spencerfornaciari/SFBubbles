//
//  SFBubbleView.h
//  SFBubbles
//
//  Created by Spencer Fornaciari on 11/3/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ColorAddons.h"

@protocol SFBubbleViewDelegate <NSObject>
//-(void)handleTapFrom:(UITapGestureRecognizer *)recognizer;
@end


@interface SFBubbleView : UIView

@property (weak, nonatomic) id <SFBubbleViewDelegate> delegate;

@property (strong, nonatomic) UIDynamicAnimator *bubAnimator;
@property (strong, nonatomic) UIGravityBehavior *bubGravity;
@property (strong, nonatomic) UICollisionBehavior *bubCollision;
@property (strong, nonatomic) UIDynamicItemBehavior *bubItemBehaviour;

@end
