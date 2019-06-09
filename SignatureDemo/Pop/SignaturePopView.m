//
//  SignaturePopView.m
//  SignatureDemo
//
//  Created by GuoWei Li on 2019/6/9.
//  Copyright © 2019 gw. All rights reserved.
//

#import "SignaturePopView.h"

@interface SignaturePopView ()

@property (nonatomic, strong) SignatureView *signatureView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *bgView;

@end

static CGFloat bgViewH = 550;
@implementation SignaturePopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, KUIScreenHeight, KUIScreenWidth, bgViewH)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    NSArray *titles = @[@"撤销", @"清屏", @"保存"];
    CGFloat btnW = 80;
    CGFloat btnH = 40;
    CGFloat margin = 15;
    CGFloat padding = (KUIScreenWidth - btnW * 3 - margin * 2) / 2;
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(margin + (btnW + padding) * i, 10, btnW, btnH)];
        btn.tag = i;
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, KUIScreenWidth, 90)];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 0.5;
    [bgView addSubview:imageView];
    self.imageView = imageView;
    
    
    CGFloat signatureViewH = 400;
    SignatureView *signatureView = [[SignatureView alloc] initWithFrame:CGRectMake(0, bgViewH - signatureViewH, KUIScreenWidth, signatureViewH)];
    [bgView addSubview:signatureView];
    self.signatureView = signatureView;
    [UIView animateWithDuration:0.3 animations:^{
        bgView.transform = CGAffineTransformTranslate(bgView.transform, 0, - bgViewH);
    } completion:^(BOOL finished) {
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, 0, bgViewH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];   
}

- (void)btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            [self.signatureView revoke];
            break;
        case 1:
            [self.signatureView clearScreen];
            break;
        case 2:
            if (!self.signatureView.image) {
                NSLog(@"请签名~~~");
            } else {
                self.imageView.image = self.signatureView.image;
            }
            break;
            
        default:
            break;
    }
}

@end
