//
//  SignatureModel.h
//  GWTest
//
//  Created by GuoWei Li on 2019/6/8.
//  Copyright © 2019 GW L. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignatureModel : NSObject

@property (nonatomic, strong) NSMutableArray<NSMutableArray *> * lines;
@property (nonatomic, strong) void(^dataUpdate)(void);
@property (nonatomic, strong) void(^dataReduceUpdate)(void);

- (void)addPointStr:(NSString *)pointStr shouldAddToPreviousLine:(BOOL)privious;

//获取线数目
- (NSUInteger)getLineCount;

//获取最后一条线
- (NSMutableArray *)getTheLastLine;

//清空数据的方法
- (void)removeAllLines;
//移除最后一条数据
//对应调用dataReduceUpdate
- (void)removeTheLastLine;

@end

NS_ASSUME_NONNULL_END
