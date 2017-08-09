//
//  HHZMemoryLabel.m
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZMemoryLabel.h"
#import "mach/mach.h"

@interface HHZMemoryLabel ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * memoryLabel;
@end

@implementation HHZMemoryLabel

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
    _titleLabel.text = @"Memory:";
    _titleLabel.frame = CGRectMake(3, (self.bounds.size.height - 20)/2, 60, 20);
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:_titleLabel];
    
    _memoryLabel = [[UILabel alloc] init];
    _memoryLabel.text = @"0MB";
    _memoryLabel.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 6, (self.bounds.size.height - 20)/2, (self.bounds.size.width - _titleLabel.bounds.size.width - 6), 20);
    _memoryLabel.textColor = [UIColor redColor];
    [self addSubview:_memoryLabel];
}

-(void)modifyMemory
{
    _memoryLabel.text = [NSString stringWithFormat:@"%.2fMB",[self MemoryUsage]];
}

-(CGFloat)MemoryUsage
{
    vm_size_t memory = usedMemory();
    return memory/1000.0/1000.0;
}


vm_size_t usedMemory(void)
{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

@end
