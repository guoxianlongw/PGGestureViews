//
//  KeychainData.h
//  AliPayDemo
//
//  Created by pg on 15/7/15.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainData : NSObject

/****** 是否是第一次输入 ******/
+ (BOOL)isFirstInput:(NSString *)str;

/****** 判断第二次输入 ******/
+ (BOOL)isSecondInputRight:(NSString *)str;

/****** 忘记密码 ******/
+ (void)forgotPsw;

/****** 设置密码 ******/
+ (void)setPSW:(NSString *)str;

/***** 是否有保存记录 ******/
+ (BOOL)isSave;












/****   KeychainData.m  *****/
/*****************   根据keychain官网的，封装，增，取，删。都只需一句话  *********************/
+ (void)setObject:(id)object forKey:(id)key;
+ (id)objectForKey:(id)key;
+ (void)removeObjectForKey:(id)key;









@end
