//
//  SignatureViewController.m
//  SignatureDemo
//
//  Created by GuoWei Li on 2019/6/9.
//  Copyright © 2019 gw. All rights reserved.
//

#import "SignatureViewController.h"

@interface SignatureViewController ()

@property (nonatomic, strong) SignatureView *signatureView;

@end

@implementation SignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem *revokeItem = [[UIBarButtonItem alloc] initWithTitle:@"撤销" style:UIBarButtonItemStylePlain target:self action:@selector(revoke)];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(clear)];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.leftBarButtonItems = @[backItem, revokeItem, clearItem];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = YES;
    //调用横屏代码
    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    
    SignatureView *signatureView = [[SignatureView alloc] init];
    [self.view addSubview:signatureView];
    self.signatureView = signatureView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 适配X系
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = self.view.safeAreaInsets;
    }
    self.signatureView.frame = CGRectMake(safeAreaInsets.left, 0, KUIScreenWidth - safeAreaInsets.left - safeAreaInsets.right, KUIScreenHeight - safeAreaInsets.bottom);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.navigationController) {
        //禁用侧滑手势方法
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.navigationController) {
        //打开侧滑手势方法
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)backAction {
    //点击导航栏返回按钮的时候调用，所以Push出的控制器最好禁用侧滑手势：
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    //切换到竖屏
    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)clear {
    [self.signatureView clearScreen];
}

- (void)revoke {
    [self.signatureView revoke];
}

- (void)save {
    NSLog(@"保存图片: %@",self.signatureView.image);
}

@end
