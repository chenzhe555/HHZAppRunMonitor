//
//  HHZFPSLabel.m
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZFPSLabel.h"

@interface HHZFPSLabel ()
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * fpsLabel;
@end

@implementation HHZFPSLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createLabels];
    }
    return self;
}

-(void)createLabels
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"FPS:";
    _titleLabel.frame = CGRectMake(3, (self.bounds.size.height - 20)/2, 60, 20);
    [self addSubview:_titleLabel];
    
    _fpsLabel = [[UILabel alloc] init];
    _fpsLabel.text = @"60";
    _fpsLabel.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 6, (self.bounds.size.height - 20)/2, (self.bounds.size.width - _titleLabel.bounds.size.width - 6), 20);
    _fpsLabel.textColor = [UIColor redColor];
    [self addSubview:_fpsLabel];
}

-(void)modifyFPS:(CADisplayLink *)link
{
    if (_lastTime == 0)
    {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval interval = link.timestamp - _lastTime;
    if (interval < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / interval;
    _count = 0;
    
    _fpsLabel.text = [NSString stringWithFormat:@"%d",(int)round(fps)];
}



@end
