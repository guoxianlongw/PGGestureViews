//
//  Header.h
//  AliPayDemo
//
//  Created by pg on 15/7/10.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#ifndef AliPayDemo_Header_h
#define AliPayDemo_Header_h


#endif


















/******************* ITEM *********************/

#define ITEMRADIUS_OUTTER    70  //item的外圆直径
#define ITEMRADIUS_INNER     20  //item的内圆直径
#define ITEMRADIUS_LINEWIDTH 1   //item的线宽
#define ITEMWH               70  //item的宽高
#define ITEM_TOTAL_POSITION  250  // 整个item的顶点位置









/*********************** subItem *************************/

#define SUBITEMTOTALWH 50 // 整个subitem的大小
#define SUBITEMWH      12  //单个subitem的大小
#define SUBITEM_TOP    80 //整个的subitem的顶点位置(y点)








/*********************** 颜色 *************************/

//背景色   深蓝色
#define BACKGROUNDCOLOR [UIColor colorWithRed:0.05 green:0.2 blue:0.35 alpha:1]

//选中颜色  浅蓝色
#define SELECTCOLOR [UIColor colorWithRed:0.13 green:0.7 blue:0.96 alpha:1]


//选错的颜色  红色
#define WRONGCOLOR [UIColor colorWithRed:1 green:0 blue:0 alpha:1]

//文字错误提示颜色   浅红色
#define LABELWRONGCOLOR [UIColor colorWithRed:0.94 green:0.31 blue:0.36 alpha:1]








/*********************** 文字提示语 *************************/
#define SETPSWSTRING          @"请滑动设置密码"
#define RESETPSWSTRING        @"请再次滑动确认密码"
#define PSWSUCCESSSTRING      @"设置密码成功"
#define PSWFAILTSTRING        @"密码错误"
#define PSW_WRONG_NUMSTRING   @"请至少设置4个点"
#define INPUT_OLD_PSWSTRING   @"请输入原始密码"
#define INPUT_NEW_PSWSTRING   @"请输入新密码"
#define VALIDATE_PSWSTRING    @"验证密码"
#define VALIDATE_PSWSTRING_SUCCESS    @"登录成功"






