//
//  AliPayItem.m
//  AliPayDemo
//
//  Created by pg on 15/7/10.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#import "AliPayItem.h"
#import "Header.h"




@implementation AliPayItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initViewsss];
        
    }
    return self;
}

- (CAShapeLayer *)innerLayer
{
    if (_innerLayer==nil) {
        _innerLayer = [CAShapeLayer layer];
        _innerLayer.frame = CGRectMake((self.frame.size.width-ITEMRADIUS_INNER)/2 , (self.frame.size.width-ITEMRADIUS_INNER)/2 , ITEMRADIUS_INNER, ITEMRADIUS_INNER);
        _innerLayer.fillColor = [UIColor clearColor].CGColor;
        
        UIBezierPath *innerLayer = [UIBezierPath bezierPathWithOvalInRect:self.innerLayer.bounds];
        _innerLayer.path = innerLayer.CGPath;
        
    }
    return _innerLayer;
}

- (CAShapeLayer *)outterLayer
{
    if (_outterLayer==nil) {
        _outterLayer = [CAShapeLayer layer];
        _outterLayer.frame = CGRectMake( (self.frame.size.width-ITEMRADIUS_OUTTER)/2 , (self.frame.size.width-ITEMRADIUS_OUTTER)/2 , ITEMRADIUS_OUTTER , ITEMRADIUS_OUTTER);
        _outterLayer.fillColor = BACKGROUNDCOLOR.CGColor;
        _outterLayer.strokeColor = [UIColor whiteColor].CGColor;
        _outterLayer.lineWidth = ITEMRADIUS_LINEWIDTH;
        
        UIBezierPath *outterLayer = [UIBezierPath bezierPathWithOvalInRect:self.outterLayer.bounds];
        _outterLayer.path = outterLayer.CGPath;
        
    }
    return _outterLayer;
}

- (CAShapeLayer *)triangleLayer
{
    if (_triangleLayer==nil) {
        _triangleLayer = [CAShapeLayer layer];
        _triangleLayer.frame = CGRectZero;
        _triangleLayer.fillColor = SELECTCOLOR.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.frame.size.width/2 , self.innerLayer.frame.origin.y-10 )];
        [path addLineToPoint:CGPointMake(self.frame.size.width/2-5, self.innerLayer.frame.origin.y-3)];
        [path addLineToPoint:CGPointMake(self.frame.size.width/2+5, self.innerLayer.frame.origin.y-3)];
        _triangleLayer.path = path.CGPath;
    
    }
    
    return _triangleLayer;
}



/**
 *  init
 */
- (void)initViewsss
{
    [self.layer addSublayer:self.outterLayer];
    [self.layer addSublayer:self.innerLayer];
    [self.layer addSublayer:self.triangleLayer];
    self.triangleLayer.hidden = YES;
}





- (void)setModel:(selectStyleModel)model
{
    switch (model)
    {
        case normalStyle:
            [self normalUI];
            break;
            
        case selectStyle:
            [self selectUI];
            break;
            
        case wrongStyle:
            [self wrongUI];
            break;
            
        default:
            break;
    }
}



- (void)normalUI
{
    self.innerLayer.fillColor    = [UIColor clearColor].CGColor;
    self.outterLayer.strokeColor = [UIColor whiteColor].CGColor;
}

- (void)selectUI
{
    self.innerLayer.fillColor    = SELECTCOLOR.CGColor;
    self.outterLayer.strokeColor = SELECTCOLOR.CGColor;
}

- (void)wrongUI
{
    self.innerLayer.fillColor    = WRONGCOLOR.CGColor;
    self.outterLayer.strokeColor = WRONGCOLOR.CGColor;
}





- (void)judegeDirectionActionx1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 isHidden:(BOOL)isHidden
{
    if (isHidden) {
        self.triangleLayer.hidden = YES;
        return;
    }
    if (x1==x2 && y1==y2) {
        return;
    }
    if (x1==0 && y1==0) {
        return;
    }
    if (x2==0 && y2==0) {
        return;
    }
    if (self.triangleLayer.hidden==NO) {
        return;
    }
    
    
    
    
    self.triangleLayer.hidden = NO;
    CGFloat angle ;
    
    if (x1<x2 && y1>y2) {
        // 左上
        angle = M_PI_4;
    }
    
    
    else if (x1<x2 && y1==y2) {
        // 左
        angle = M_PI_2;
    }
    
    
    else if (x1<x2 && y1<y2) {
        // 左下
         angle = M_PI_4 * 3;
    }
    
    
    else if (x1==x2 && y1<y2) {
        // 下
        angle = M_PI;
    }
    
    
    else if (x1>x2 && y1<y2) {
        // 右下
        angle = -M_PI_4 * 3;
    }
    
    
    else if (x1>x2 && y1==y2) {
        // 右
        angle = - M_PI_2;
    }
    
    
    else if (x1>x2 && y1>y2) {
        // 右上
        angle = - M_PI_4 *3 ;
    }
    
    else {
        angle = .0f;
    }
    
    //NSLog(@"..................... angle = [%f]", angle);
    self.transform = CGAffineTransformMakeRotation(angle);

    
}









@end
