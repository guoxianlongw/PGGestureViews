//
//  ViewController.m
//  AliPayDemo
//
//  Created by pg on 15/7/8.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#import "ViewController.h"

#import "AliPayViews.h"
#import "KeychainData.h"

#import "SetpasswordViewController.h"
#import "MBProgressHUD.h"


#define BACKCOLOR [UIColor colorWithRed:0.05 green:0.2 blue:0.35 alpha:1]



@interface ViewController ()
{
    UIButton *twoButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    AliPayView *aliView = [[AliPayView alloc] initWithFrame:self.view.frame];
//    
//    [self.view addSubview:aliView];
    
    
    
//    
//    AliPayViews *alipay = [[AliPayViews alloc] initWithFrame:self.view.bounds];
// 
//    alipay.block = ^(NSMutableArray *pwdArr)
//    {
//        NSLog(@"\n\n你的密码为 = 【%@】\n\n", pwdArr);
//    };
//    
////    [self.view addSubview:alipay];
//    
    
    
    
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, 70, 320, 50);
    oneButton.backgroundColor = [UIColor grayColor];
    [oneButton setTitle:@"重新设置密码（就密码自动作废）" forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(setPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneButton];
    
    
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(0, 200, 320, 50);
    twoButton.backgroundColor = [UIColor grayColor];
    [twoButton setTitle:@"忘记密码，没有任何提示，即已成功" forState:UIControlStateNormal];
    [twoButton addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoButton];
    
    
    
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    threeButton.frame = CGRectMake(0, 320, 277, 50);
    threeButton.backgroundColor = [UIColor grayColor];
    [threeButton setTitle:@" 修改密码" forState:UIControlStateNormal];
    [threeButton addTarget:self action:@selector(alertPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:threeButton];
    
    
    
    UIButton *fourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fourButton.frame = CGRectMake(0, 470, 320, 50);
    fourButton.backgroundColor = [UIColor grayColor];
    [fourButton setTitle:@"验证密码" forState:UIControlStateNormal];
    [fourButton addTarget:self action:@selector(validatePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fourButton];
    
    

    
}



/**
 *  设置密码
 */
- (void)setPassword
{
    
    [self forgotPassword];
    SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
    setpass.string = @"重置密码";
    [self presentViewController:setpass animated:YES completion:nil];
    

}





/**
 *  忘记密码
 */
- (void)forgotPassword
{
    
    [KeychainData forgotPsw];

    
    [self hudAction:@"忘记密码"];
    
}







/**
 *  修改密码
 */
- (void)alertPassword
{
    BOOL isSave = [KeychainData isSave]; //是否有保存
    if (isSave) {
        
        SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
        setpass.string = @"修改密码";
        [self presentViewController:setpass animated:YES completion:nil];
    } else {
        [self hudAction:@"还没有设置密码，不能修改密码"];
    }
    
}



/**
 *  验证密码
 */
- (void)validatePassword
{
    BOOL isSave = [KeychainData isSave]; //是否有保存
    if (isSave) {
        
        SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
        setpass.string = @"验证密码";
        [self presentViewController:setpass animated:YES completion:nil];
        
    } else {
        [self hudAction:@"还没有设置密码，不能直接登录"];
    }
    
    
}










/**
 *  hud
 */

- (void)hudAction:(NSString *)contextStr
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = contextStr;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud show:YES];
    [self.view addSubview:hud];
    [self performSelector:@selector(removeHUB:) withObject:hud afterDelay:1];

}
- (void)removeHUB:(MBProgressHUD *)hud
{
    if (hud) {
        [hud  hide:YES];
        [hud removeFromSuperview];
        hud = nil;
    }
}




@end
