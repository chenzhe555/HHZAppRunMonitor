//
//  HHZCPULabel.m
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZCPULabel.h"
#import <HHZUtils/HHZDeviceTool.h>

@interface HHZCPULabel ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * cpuLabel;
@end

@implementation HHZCPULabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLabels];
    }
    return self;
}

-(void)createLabels
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"CPU:";
    _titleLabel.frame = CGRectMake(3, (self.bounds.size.height - 20)/2, 60, 20);
    [self addSubview:_titleLabel];
    
    _cpuLabel = [[UILabel alloc] init];
    _cpuLabel.text = @"0%";
    _cpuLabel.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 6, (self.bounds.size.height - 20)/2, (self.bounds.size.width - _titleLabel.bounds.size.width - 6), 20);
    _cpuLabel.textColor = [UIColor redColor];
    [self addSubview:_cpuLabel];
}

-(void)modifyCPU
{
    _cpuLabel.text = [NSString stringWithFormat:@"%f",[HHZDeviceTool getCPUUsage]];
}

@end
