//
//  LSRippleView.m
//  LSDemo
//
//  Created by hanfeng.li on 2017/5/16.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import "LSRippleView.h"

#define DEFAULT_BACKGROUND_COLOR [UIColor colorWithRed:103 / 255.0f green:170 / 255.0f blue:255 / 255.0f alpha:1].CGColor

@interface LSRippleView ()
@property (nonatomic, strong) CALayer *rippleLayer;
@end

@implementation LSRippleView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    [self rippleLayer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        [self rippleLayer];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.rippleLayer.position = point;
    [CATransaction commit];
    [self startAnimation];
}

- (CALayer *)rippleLayer {
    if (_rippleLayer == nil) {
        CGFloat radius = MAX(self.layer.bounds.size.width, self.layer.bounds.size.height);
        CGFloat diameter = radius * 2;
        _rippleLayer = [[CALayer alloc]init];
        _rippleLayer.frame = CGRectMake(0, 0, diameter, diameter);
        _rippleLayer.cornerRadius = radius;
        _rippleLayer.position = CGPointMake(self.layer.bounds.size.width / 2, self.layer.bounds.size.height / 2);
        _rippleLayer.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        _rippleLayer.opacity = 0;
        [self.layer insertSublayer:_rippleLayer above:self.layer];
    }
    return _rippleLayer;
}

- (void)setRippleColor:(UIColor *)rippleColor {
    _rippleColor = rippleColor;
    _rippleLayer.backgroundColor = rippleColor.CGColor;
}

- (void)startAnimation {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 1;
    animationGroup.repeatCount = 0;
    animationGroup.removedOnCompletion = YES;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @0.1f;
    scaleAnimation.toValue = @1;
    scaleAnimation.duration = 1;
    scaleAnimation.autoreverses = NO;
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 1;
    opacityAnimation.values = @[@0.2, @0.5, @0.1];
    opacityAnimation.keyTimes = @[@0, @0.3, @1];
    opacityAnimation.removedOnCompletion = YES;
    
    NSMutableArray *animations = [NSMutableArray arrayWithCapacity:3];
    [animations addObject:scaleAnimation];
    [animations addObject:opacityAnimation];
    animationGroup.animations = animations;
    
    [self.rippleLayer addAnimation:animationGroup forKey:nil];
}

@end
