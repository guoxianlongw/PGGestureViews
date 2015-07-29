//
//  AliPayViews.m
//  AliPayDemo
//
//  Created by pg on 15/7/9.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#import "AliPayViews.h"
#import "AliPayItem.h"
#import "Header.h"
#import "KeychainData.h"
#import "AlipaySubItem.h"

#define KscreenHeight [UIScreen mainScreen].bounds.size.height
#define KscreenWidth [UIScreen mainScreen].bounds.size.width

#define ITEMTAG 122

@interface AliPayViews()
@property(nonatomic , strong)NSMutableArray *btnArray;
@property(nonatomic , assign)CGPoint movePoint;
@property(nonatomic , strong)AlipaySubItem *subItemsss;
@property(nonatomic , strong)UILabel *tfLabel;
@property(nonatomic , assign)CGPoint lastPoint;
@end



@implementation AliPayViews

- (NSMutableArray *)btnArray
{
    if (_btnArray==nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UILabel *)tfLabel
{
    if (_tfLabel==nil) {
        _tfLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.subItemsss.frame.origin.y+50, KscreenWidth , 40)];
        _tfLabel.textAlignment = NSTextAlignmentCenter;
        _tfLabel.textColor = [UIColor whiteColor];
        _tfLabel.text = SETPSWSTRING;
        [self addSubview:_tfLabel];
    }
    return _tfLabel;
}


- (AlipaySubItem *)subItemsss
{
    if (_subItemsss==nil) {
        _subItemsss = [[AlipaySubItem alloc] initWithFrame:CGRectMake((self.frame.size.width-SUBITEMTOTALWH)/2, SUBITEM_TOP, SUBITEMTOTALWH, SUBITEMTOTALWH)];
        [self addSubview:_subItemsss];
    }
    return _subItemsss;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViews];
        
    }
    return self;
}

#pragma mark - init
- (void)initViews
{
    self.backgroundColor = BACKGROUNDCOLOR;
    
    /*******  上面的9个小点 ******/
    self.subItemsss.backgroundColor = [UIColor clearColor];
    
    
    /***** 提示文字 ******/
    self.tfLabel.backgroundColor = [UIColor clearColor];
    
    
    /****** 9个大点的布局 *****/
    [self createPoint_nine];


    /******* 小按钮上三角的point ******/
    _lastPoint = CGPointMake(0, 0);
}






#pragma mark - Touch Event
/**
 *  begin
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint point = [self touchLocation:touches];
    
    [self isContainItem:point];
    
}


/**
 *  touch Move
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint point = [self touchLocation:touches];
    
    [self isContainItem:point];
    
    [self touchMove_triangleAction];
    
    [self setNeedsDisplay];

}


/**
 *  touch End
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self touchEndAction];
    
    [self setNeedsDisplay];
    

}



#pragma mark - UILabel  property
- (void)shake:(UIView *)myView
{
    int offset = 8 ;
    
    CALayer *lbl = [myView layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-offset, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+offset, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.06];
    [animation setRepeatCount:2];
    [lbl addAnimation:animation forKey:nil];
    
}





- (void)setGestureModel:(GestureModel)gestureModel
{
    _gestureModel = gestureModel;
    self.tfLabel.textColor = [UIColor whiteColor];

    switch (gestureModel) {
            
        case AlertPwdModel:
            //修改密码
            self.tfLabel.text = INPUT_OLD_PSWSTRING; //请输入原始密码
            break;
            
        case SetPwdModel:
            //重置密码
            self.tfLabel.text = SETPSWSTRING;        //请滑动设置密码
            break;
            
        case ValidatePwdModel:
            //验证密码
            self.tfLabel.text = VALIDATE_PSWSTRING; //验证密码
            break;
            
        case DeletePwdModel:
            //删除密码
            [KeychainData forgotPsw];
            break;
            
        default:
            break;
    }
}





#pragma mark - total method

/**
 *  下面的9个划线的点   init
 */
- (void)createPoint_nine
{
    
    for (int i=0; i<9; i++)
    {
        int row    = i / 3;
        int column = i % 3;
        
        CGFloat spaceFloat = (KscreenWidth-3*ITEMWH)/4;             //每个item的间距是等宽的
        CGFloat pointX     = spaceFloat*(column+1)+ITEMWH*column;   //起点X
        CGFloat pointY     = ITEM_TOTAL_POSITION + ITEMWH*row + spaceFloat*row;     //起点Y
        
        /**
         *  对每一个item的frame的布局
         */
        AliPayItem *item = [[AliPayItem alloc] initWithFrame:CGRectMake( pointX  , pointY , ITEMWH, ITEMWH)];
        item.userInteractionEnabled = YES;
        item.backgroundColor = [UIColor clearColor];
        item.isSelect = NO;
        item.tag = ITEMTAG + i ;
        [self addSubview:item];
        
        //NSLog(@"item.frame = [%@]", NSStringFromCGPoint(item.center));
    }
}

/**
 *  touch  begin move
 */

- (CGPoint)touchLocation:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _movePoint = point;
    
    return point;
}

- (void)isContainItem:(CGPoint)point
{
    for (AliPayItem *item  in self.subviews)
    {
        if (![item isKindOfClass:[AlipaySubItem class]] && [item isKindOfClass:[AliPayItem class]])
        {
            BOOL isContain = CGRectContainsPoint(item.frame, point);
            if (isContain && item.isSelect==NO)
            {
                [self.btnArray addObject:item];
                item.isSelect = YES;
                item.model = selectStyle;
            }
        }
        
    }
    
}

- (void)touchMove_triangleAction
{
    NSString *resultStr = [self getResultPwd];
    if (resultStr&&resultStr.length>0   )
    {
        NSArray *resultArr = [resultStr componentsSeparatedByString:@"A"];
        if ([resultArr isKindOfClass:[NSArray class]]  &&  resultArr.count>2 )
        {
            NSString *lastTag    = resultArr[resultArr.count-1];
            NSString *lastTwoTag = resultArr[resultArr.count-2];

            CGPoint lastP ;
            CGPoint lastTwoP;
            AliPayItem *lastItem;
            
            for (AliPayItem *item  in self.btnArray)
            {
                if (item.tag-ITEMTAG == lastTag.intValue)
                {
                    lastP = item.center;
                }
                if (item.tag-ITEMTAG == lastTwoTag.intValue)
                {
                    lastTwoP = item.center;
                    lastItem = item;
                }
                
                CGFloat x1 = lastTwoP.x;
                CGFloat y1 = lastTwoP.y;
                CGFloat x2 = lastP.x;
                CGFloat y2 = lastP.y;

                [lastItem judegeDirectionActionx1:x1 y1:y1 x2:x2 y2:y2 isHidden:NO];

            }
            
            
            
        }
    }
}

/**
 *  touch end
 */
- (void)touchEndAction
{
    for (AliPayItem *itemssss in self.btnArray)
    {
        [itemssss judegeDirectionActionx1:0 y1:0 x2:0 y2:0 isHidden:NO];
    }
    
    
    // if (判断格式少于4个点) [处理密码数据]
    if ([self judgeFormat]) [self setPswMethod:[self getResultPwd]] ;

    
    // 数组清空
    [self.btnArray removeAllObjects];
    
    
    // 选中样式
    for (AliPayItem *item  in self.subviews)
    {
        if (![item isKindOfClass:[AlipaySubItem class]] && [item isKindOfClass:[AliPayItem class]])
        {
            item.isSelect = NO;
            item.model = normalStyle;
            [item judegeDirectionActionx1:0 y1:0 x2:0 y2:0 isHidden:YES];
        }
        
    }
    
}



/**
 *  少于4个点
 */
- (BOOL)judgeFormat
{
    if (self.btnArray.count<=3) {
        //不合法
        self.tfLabel.textColor = LABELWRONGCOLOR;
        self.tfLabel.text      = PSW_WRONG_NUMSTRING;
        [self shake:self.tfLabel];
        return NO;
    }
    
    return YES;
}

/**
 *  对密码str进行处理
 */
- (NSString *)getResultPwd
{
    NSMutableString *resultStr = [NSMutableString string];
    
    for (AliPayItem *item  in self.btnArray)
    {
        if (![item isKindOfClass:[AlipaySubItem class]] && [item isKindOfClass:[AliPayItem class]])
        {
            [resultStr appendString:@"A"];
            [resultStr appendString:[NSString stringWithFormat:@"%ld", (long)item.tag-ITEMTAG]];
        }
    }
    
    return (NSString *)resultStr;
}




#pragma mark - 处理修改，设置，登录的业务逻辑
- (void)setPswMethod:(NSString *)resultStr
{
    //没有任何记录，第一次登录
    BOOL isSaveBool = [KeychainData isFirstInput:resultStr];
    
    //默认为蓝色
    UIColor *color = SELECTCOLOR;
    
    if (isSaveBool) {
        
        //第一次输入之后，显示的文字
        self.tfLabel.text = RESETPSWSTRING;
        self.tfLabel.textColor = [UIColor whiteColor];
        
    } else {
        //密码已经存在
        //1 , 修改
        //2 , 验证
        //3 , 登录
        
        //设置密码
        color = [self setPwdJudgeAction:color str:resultStr];
        
        //修改密码
        color = [self alertPwdJudgeAction:color str:resultStr];
        
        //验证密码
        color = [self validatePwdJudgeAction:color str:resultStr];
        
    }
    
    /**************  小键盘颜色 ***************/
    [self.subItemsss resultArr:(NSArray *)[resultStr componentsSeparatedByString:@"A"] fillColor:color];
    
}



/**
 *  设置密码
 */
- (UIColor *)setPwdJudgeAction:(UIColor *)color str:(NSString *)resultStr
{
    /**
     *  设置密码
     */
    if (self.gestureModel == SetPwdModel) {
        
        // isRight == YES 2次的密码相同
        BOOL isRight = [KeychainData isSecondInputRight:resultStr];
        if (isRight) {
            // 验证成功
            
            self.tfLabel.text = PSWSUCCESSSTRING;
            self.tfLabel.textColor =  [UIColor whiteColor];
            [self performSelector:@selector(blockAction:) withObject:resultStr afterDelay:.8];
            
        } else {
            
            // 失败
            self.tfLabel.text = PSWFAILTSTRING;
            self.tfLabel.textColor = LABELWRONGCOLOR;
            [self shake:self.tfLabel];
            color = LABELWRONGCOLOR;
            
        }
    }
    return color;
}
/**
 *  修改密码
 */
- (UIColor *)alertPwdJudgeAction:(UIColor *)color str:(NSString *)resultStr
{
    /**
     *  修改
     */
    if (self.gestureModel == AlertPwdModel)
    {
        BOOL isValidate = [KeychainData isSecondInputRight:resultStr];
        if (isValidate) {
            
            //如果验证成功
            [KeychainData forgotPsw];
            self.tfLabel.text = INPUT_NEW_PSWSTRING;
            self.tfLabel.textColor = [UIColor whiteColor];
            _gestureModel = SetPwdModel;
            
        } else {
            //验证失败
            self.tfLabel.text = PSWFAILTSTRING;
            self.tfLabel.textColor = LABELWRONGCOLOR;
            [self shake:self.tfLabel];
            color = LABELWRONGCOLOR;
        }
    }
    return color;
}

/**
 *  验证，登录
 */
- (UIColor *)validatePwdJudgeAction:(UIColor *)color str:(NSString *)resultStr
{
    
    
    if (self.gestureModel == ValidatePwdModel) {
        BOOL isValidate = [KeychainData isSecondInputRight:resultStr];
        if (isValidate) {
            //如果验证成功
            self.tfLabel.text = VALIDATE_PSWSTRING_SUCCESS;
            self.tfLabel.textColor = [UIColor whiteColor];
            [self performSelector:@selector(blockAction:) withObject:resultStr afterDelay:.8];
            
        } else {
            //失败
            self.tfLabel.text = PSWFAILTSTRING;
            self.tfLabel.textColor = LABELWRONGCOLOR;
            [self shake:self.tfLabel];
            color = LABELWRONGCOLOR;

        }
    }
    
    return color;
}

/**
 *   成功的block回调
 */
- (void)blockAction:(NSString *)resultStr
{
    if (self.block)
    {
        _gestureModel = NoneModel;
        self.block([resultStr stringByReplacingOccurrencesOfString:@"A" withString:@"__"]);
    }
}







#pragma mark - drawRect
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];

    for (int i=0; i<self.btnArray.count; i++)
    {
        AliPayItem *item = (AliPayItem *)self.btnArray[i];
        if (i==0)
        {
            [path moveToPoint:item.center];
        }
        else
        {
            [path addLineToPoint:item.center];
        }
    }
    
    if (_movePoint.x!=0 && _movePoint.y!=0 && NSStringFromCGPoint(_movePoint))
    {
        [path addLineToPoint:_movePoint];
    }
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineWidth:1.0f];
    [SELECTCOLOR setStroke];
    [path stroke];
    
    
}






@end
