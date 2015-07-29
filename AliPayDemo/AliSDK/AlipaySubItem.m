//
//  AlipaySubItem.m
//  AliPayDemo
//
//  Created by pg on 15/7/14.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#import "AlipaySubItem.h"
#import "Header.h"
#define ALIPAYSUBITEMTAG 33

@interface AlipaySubItem()
//@property(nonatomic , strong)CAShapeLayer *shape;
@end


@implementation AlipaySubItem




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}


- (void)initViews
{
    for (int i=0; i<9; i++)
    {
        int row        = i / 3 ;
        int column     = i % 3 ;
        CGFloat x_or_y = (SUBITEMTOTALWH-3*SUBITEMWH)/4 ;
        CGFloat posX   = x_or_y*(column+1)+column*SUBITEMWH ;
        CGFloat posY   = x_or_y*(row+1)+row*SUBITEMWH ;
        

        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake( posX , posY , SUBITEMWH , SUBITEMWH)];
        myView.tag = i + ALIPAYSUBITEMTAG;
        [self addSubview:myView];
        
        
        [self drawCircle:myView color:[UIColor clearColor]];
    }
}




- (void)drawCircle:(UIView *)myView color:(UIColor *)color
{
    if (color == [UIColor clearColor])
    {
        myView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        myView.backgroundColor = color;
    }
    
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake( 1 , 1 , SUBITEMWH-2 , SUBITEMWH-2);
    shape.fillColor = color.CGColor;
    if (color == [UIColor clearColor])
    {
        shape.strokeColor = [UIColor whiteColor].CGColor;
    }
    else
    {
        shape.strokeColor = color.CGColor;
    }
    shape.lineWidth = 1;
    myView.layer.mask = shape;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:shape.bounds];
    shape.path = path.CGPath;
}






- (void)resultArr:(NSArray *)array fillColor:(UIColor *)color
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([array containsObject:[NSString stringWithFormat:@"%lu", (unsigned long)idx]])
        {
            // 如果array里包含idx，填充为白色
            UIView *myView = (UIView *)[self viewWithTag:(idx+ALIPAYSUBITEMTAG)];
            [self drawCircle:myView color:color];
            
            [self performSelector:@selector(drawCleanCircle:) withObject:myView afterDelay:1 ];
            
        }
        
    }];
}




- (void)drawCleanCircle:(UIView *)myView
{
    [self drawCircle:myView color:[UIColor clearColor]];
}












@end
