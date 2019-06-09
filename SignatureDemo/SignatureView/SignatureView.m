//
//  SignatureView.m
//  GWTest
//
//  Created by GuoWei Li on 2019/6/8.
//  Copyright © 2019 GW L. All rights reserved.
//

#import "SignatureView.h"
#import "SignatureModel.h"

static CGPoint midpoint(CGPoint p0,CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) /2.0,
        (p0.y + p1.y) /2.0
    };
}

@interface SignatureView ()

// 管理数据model
@property (nonatomic, strong) SignatureModel *model;
// 路径
@property (nonatomic, strong) UIBezierPath *path;
// 每条线的起始点
@property (nonatomic, assign) CGPoint startPoint;
// 判断是否是一条新线
@property (nonatomic, assign) BOOL newLine;

@end

@implementation SignatureView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    CAShapeLayer * shapeLayper = (CAShapeLayer *)self.layer;
    shapeLayper.masksToBounds = YES;
    shapeLayper.fillColor = [UIColor clearColor].CGColor;
    shapeLayper.backgroundColor = [UIColor whiteColor].CGColor;
    shapeLayper.lineWidth = 2.5;
    shapeLayper.lineCap = kCALineCapRound;
    shapeLayper.lineJoin = kCALineJoinRound;
    shapeLayper.strokeColor = [UIColor orangeColor].CGColor;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.newLine = YES;
    self.startPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    if (self.newLine) {
        [self addStartPoint:self.startPoint];
        self.newLine = NO;
    } else {
        [self addMovedPoint:point];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.newLine) {
        CGPoint point = [[touches anyObject] locationInView:self];
        [self addMovedPoint:point];
    }
}

#pragma mark -PrivateMethon

- (void)addStartPoint:(CGPoint)point {
    NSString *relativePointStr = [[NSString alloc] initWithFormat:@"{%.4f,%.4f}",point.x,point.y];
    [self.model addPointStr:relativePointStr shouldAddToPreviousLine:NO];
}

- (void)addMovedPoint:(CGPoint)point {
    NSString *relativePointStr = [[NSString alloc] initWithFormat:@"{%.4f,%.4f}",point.x,point.y];
    [self.model addPointStr:relativePointStr shouldAddToPreviousLine:YES];
}

- (void)bindDataWithModel:( NSMutableArray<NSMutableArray *> *)lines {
    self.model.lines = [lines mutableCopy];
    [self.path removeAllPoints];
    for (NSArray *array in self.model.lines) {
        for (int i = 0; i < array.count; i++) {
            NSString *pointStr = array[i];
            CGPoint point = CGPointFromString(pointStr);
            if (i== 0) {
                [self.path moveToPoint:point];
            } else {
                NSString *prePointStr = array[i-1];
                CGPoint prePoint = CGPointFromString(prePointStr);
                CGPoint midPoint = midpoint(prePoint, point);
                [self.path addQuadCurveToPoint:midPoint controlPoint:prePoint];
            }
        }
    }
    //自带清屏效果,path是唯一的
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

- (void)drawWithModel:(SignatureModel *)model {
    if ([model getLineCount] == 0) {
        [self.path removeAllPoints];
        
    } else {
        NSMutableArray *lastLine = [model getTheLastLine];
        NSString *pointStr = [lastLine lastObject];
        CGPoint point = CGPointFromString(pointStr);
        
        if (lastLine.count == 1) {
            [self.path moveToPoint:point];
        } else if (lastLine.count > 1) {
            NSString *prePointStr = lastLine[lastLine.count - 2];
            CGPoint prePoint = CGPointFromString(prePointStr);
            CGPoint midPoint = midpoint(prePoint, point);
            [self.path addQuadCurveToPoint:midPoint controlPoint:prePoint];
        }
    }
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

#pragma mark - PublicMethod

- (void)clearScreen {
    [self.model removeAllLines];
}

- (void)revoke {
    [self.model removeTheLastLine];
}

#pragma mark Properties

- (SignatureModel *)model {
    __weak typeof(self) ws = self;
    if (_model == nil) {
        _model = [[SignatureModel alloc] init];
        _model.dataUpdate = ^() {
            //增量更新
            [ws drawWithModel:ws.model];
        };
        
        //重新绘制,替换path
        _model.dataReduceUpdate = ^() {
            [ws bindDataWithModel:ws.model.lines];
        };
    }
    return _model;
}

- (UIBezierPath *)path {
    if (!_path) {
        _path = [[UIBezierPath alloc] init];
        _path.lineJoinStyle = kCGLineJoinRound;
        _path.lineCapStyle = kCGLineCapRound;
    }
    return _path;
}

- (UIImage *)image {
    if (self.model.lines.count == 0) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

@end
