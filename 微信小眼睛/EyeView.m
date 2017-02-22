//
//  EyeView.m
//  微信小眼睛
//
//  Created by LJP on 17/1/4.
//  Copyright © 2017年 Mumu. All rights reserved.
//

#import "EyeView.h"

#define angel2Rad(angle) ((angle) / 180.0 * M_PI)
#define BoundsCenter CGPointMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5)

static const CGFloat EyeLightScale = 0.05;
static const CGFloat EyeBallScale = 0.1;
static const CGFloat EyeSocketScale = 0.32;
static const CGFloat EyeBallAnimationMargin = 40.0;
static const CGFloat TopBottomSocketLayer = 60.0;



@interface EyeView ()
@property (nonatomic, strong)CAShapeLayer *eyeFirstLightLayer;
@property (nonatomic, strong)CAShapeLayer *eyeSecondLightLayer;
@property (nonatomic, strong)CAShapeLayer *eyeBallLayer;
@property (nonatomic, strong)CAShapeLayer *topEyesocketLayer;
@property (nonatomic, strong)CAShapeLayer *bottomEyesocketLayer;
@end

@implementation EyeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self.layer addSublayer:self.eyeFirstLightLayer];
        [self.layer addSublayer:self.eyeSecondLightLayer];
        [self.layer addSublayer:self.eyeBallLayer];
        [self.layer addSublayer:self.topEyesocketLayer];
        [self.layer addSublayer:self.bottomEyesocketLayer];
    }
    return self;
}

- (void)setupAnimation
{
    self.eyeFirstLightLayer.lineWidth = 0;
    self.eyeSecondLightLayer.lineWidth = 0;
    self.eyeBallLayer.lineWidth = 0;
    self.topEyesocketLayer.strokeStart = 0.5;
    self.topEyesocketLayer.strokeEnd = 0.5;
    self.bottomEyesocketLayer.strokeStart = 0.5;
    self.bottomEyesocketLayer.strokeEnd = 0.5;
}

- (void)animationWith:(CGFloat)y
{
    CGFloat flag = self.frame.origin.y * 2 - EyeBallAnimationMargin;
    
    if (y < flag) {
        if (self.eyeFirstLightLayer.lineWidth < 5) {
            self.eyeFirstLightLayer.lineWidth += 1;
            self.eyeSecondLightLayer.lineWidth += 1;
        }
    }
    if (y < flag - EyeBallAnimationMargin) {
        if (self.eyeBallLayer.opacity <= 1.0f) {
            self.eyeBallLayer.opacity += 0.1f;
        }
    }
    
    if (y < flag - TopBottomSocketLayer) {
        if (self.topEyesocketLayer.strokeEnd < 1 && self.topEyesocketLayer.strokeStart > 0) {
            self.topEyesocketLayer.strokeStart -= 0.1;
            self.topEyesocketLayer.strokeEnd += 0.1;
            self.bottomEyesocketLayer.strokeStart -= 0.1;
            self.bottomEyesocketLayer.strokeEnd += 0.1;
        }
    }
    
    if (y > flag - TopBottomSocketLayer) {
        if (self.topEyesocketLayer.strokeEnd >= 0.5 && self.topEyesocketLayer.strokeStart <= 0.5) {
            self.topEyesocketLayer.strokeEnd -= 0.1;
            self.topEyesocketLayer.strokeStart += 0.1;
            self.bottomEyesocketLayer.strokeStart += 0.1;
            self.bottomEyesocketLayer.strokeEnd -= 0.1;
        }
    }
    
    
    if (y > flag - EyeBallAnimationMargin) {
        if (self.eyeBallLayer.opacity >= 0.0f) {
            self.eyeBallLayer.opacity -= 0.1;
        }
    }
    
    if (y > flag) {
        if (self.eyeFirstLightLayer.lineWidth > 0) {
            self.eyeFirstLightLayer.lineWidth -= 1;
            self.eyeSecondLightLayer.lineWidth -= 1;
        }
    }
    
}

#pragma mark - setter && getter
- (CAShapeLayer *)eyeFirstLightLayer
{
    if (!_eyeFirstLightLayer) {
        _eyeFirstLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetWidth(self.frame) * EyeLightScale startAngle:angel2Rad(230.0) endAngle:angel2Rad(265.0) clockwise:YES];
        _eyeFirstLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeFirstLightLayer.lineWidth = 5.0;
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeFirstLightLayer;
}

- (CAShapeLayer *)eyeSecondLightLayer
{
    if (!_eyeSecondLightLayer) {
        _eyeSecondLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetWidth(self.frame) * EyeLightScale startAngle:angel2Rad(211.0) endAngle:angel2Rad(220.0) clockwise:YES];
        _eyeSecondLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeSecondLightLayer.lineWidth = 5;
        _eyeSecondLightLayer.path = path.CGPath;
        _eyeSecondLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeSecondLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeSecondLightLayer;
}

- (CAShapeLayer *)eyeBallLayer
{
    if (!_eyeBallLayer) {
        _eyeBallLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.bounds) * EyeBallScale
                                                        startAngle:angel2Rad(0)
                                                          endAngle:angel2Rad(360.0)
                                                         clockwise:YES];
        _eyeBallLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeBallLayer.lineWidth = 1;
        _eyeBallLayer.path = path.CGPath;
        _eyeBallLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeBallLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeBallLayer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return _eyeBallLayer;
}

- (CAShapeLayer *)topEyesocketLayer
{
    if (!_topEyesocketLayer) {
        _topEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * EyeSocketScale, CGRectGetHeight(self.bounds) * 0.5)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (1- EyeSocketScale), CGRectGetHeight(self.bounds) * 0.5) controlPoint:CGPointMake(CGRectGetWidth(self.bounds) * 0.5, center.y - center.y + 5)];
        _topEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _topEyesocketLayer.lineWidth = 1;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _topEyesocketLayer;
}

- (CAShapeLayer *)bottomEyesocketLayer
{
    if (!_bottomEyesocketLayer) {
        _bottomEyesocketLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * EyeSocketScale, CGRectGetHeight(self.bounds) * 0.5)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (1 - EyeSocketScale), CGRectGetHeight(self.bounds) * 0.5) controlPoint:CGPointMake(CGRectGetWidth(self.bounds) * 0.5, BoundsCenter.y + BoundsCenter.y - 5)];
        _bottomEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _bottomEyesocketLayer.lineWidth = 1;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    
    return _bottomEyesocketLayer;
}













@end
