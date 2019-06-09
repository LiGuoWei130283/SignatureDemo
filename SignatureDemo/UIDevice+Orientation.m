//
//  UIDevice+Orientation.m
//  GWTest
//
//  Created by GuoWei Li on 2019/6/8.
//  Copyright © 2019 GW L. All rights reserved.
//

#import "UIDevice+Orientation.h"

@implementation UIDevice (Orientation)

+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}

@end
