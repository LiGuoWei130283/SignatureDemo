//
//  SignatureModel.m
//  GWTest
//
//  Created by GuoWei Li on 2019/6/8.
//  Copyright © 2019 GW L. All rights reserved.
//

#import "SignatureModel.h"

@implementation SignatureModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lines = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger)getLineCount {
    return [self.lines count];
}

- (NSMutableArray *)getTheLastLine {
    return [self.lines lastObject];
}

- (void)addPointStr:(NSString *)pointStr shouldAddToPreviousLine:(BOOL)privious {
    if (privious) {
        [[self.lines lastObject] addObject:pointStr];
    } else {
        NSMutableArray *line = [[NSMutableArray alloc] init];
        [line addObject:pointStr];
        [self.lines addObject:line];
    }
    
    if (self.dataUpdate) {
        self.dataUpdate();
    }
}

//清空数据的方法
- (void)removeAllLines {
    [self.lines removeAllObjects];
    if (self.dataUpdate) {
        self.dataUpdate();
    }
}

- (void)removeTheLastLine {
    [self.lines removeLastObject];
    if (self.dataReduceUpdate) {
        self.dataReduceUpdate();
    }
}

@end
