//
//  SignatureView.h
//  GWTest
//
//  Created by GuoWei Li on 2019/6/8.
//  Copyright © 2019 GW L. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface SignatureView : UIView

// 签名截图,若未签名则返回nil
@property (nonatomic, strong) UIImage *image;

/**
 *  清屏
 */
- (void)clearScreen;


/**
 撤销
 */
- (void)revoke;

@end

NS_ASSUME_NONNULL_END
