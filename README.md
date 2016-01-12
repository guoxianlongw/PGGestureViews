# PGGestureViews
高仿支付宝手势解锁，用keychain保存密码，将苹果官方keychain进一步封装，用法和NSUserdefault相同。无图片，解耦性强，使用coregraphic绘制。

![gifImage](https://raw.githubusercontent.com/guoxianlongw/PGGestureViews/master/PGGPic.gif)


![PGGestureViews](https://raw.githubusercontent.com/guoxianlongw/PGGestureViews/master/1.png)
![PGGestureViews](https://raw.githubusercontent.com/guoxianlongw/PGGestureViews/master/2.png)


      //typedef enum {
      //    AlertPwdModel,    //修改密码 (需要先输入老密码)
      //    SetPwdModel,      //重置密码（无论存不存老密码都一并删除，在重新设置密码）
      //    ValidatePwdModel, //验证密码 (输入一遍，进行验证)
      //    DeletePwdModel,   //删除密码
      //    NoneModel
      //}GestureModel;



    ///调用手势解锁页面
    AliPayViews *alipay = [[AliPayViews alloc] initWithFrame:self.view.bounds];
    alipay.gestureModel = ValidatePwdModel;
    
    alipay.block = ^(NSString *pswString) {
        NSLog(@"设置密码成功-----你的密码为 = 【%@】\n\n", pswString);
        [self dismissViewControllerAnimated:YES completion:nil];  // 消失你的页面
        
    };
    [self.view addSubview:alipay];
    



    /****   KeychainData.m  *****/
    /*****************   根据keychain官网的，封装，增，取，删。都只需一句话  *********************/
    + (void)setObject:(id)object forKey:(id)key;
    + (id)objectForKey:(id)key;
    + (void)removeObjectForKey:(id)key;



