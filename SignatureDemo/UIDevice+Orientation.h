//
//  UIDevice+Orientation.h
//  GWTest
//
//  Created by GuoWei Li on 2019/6/8.
//  Copyright © 2019 GW L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Orientation)

/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end

NS_ASSUME_NONNULL_END
