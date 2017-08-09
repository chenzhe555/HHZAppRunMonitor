//
//  HHZCPULabel.m
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZCPULabel.h"
#import "mach/mach.h"

@interface HHZCPULabel ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * cpuLabel;
@end

@implementation HHZCPULabel

-(instancetype)initWithFrame:(CGRect)frame
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
    _cpuLabel.text = [NSString stringWithFormat:@"%.2f\%%",[self gainCPUUsage]];
}


-(CGFloat)gainCPUUsage
{
    return cpu_usage();
}






#pragma mark 网上找的一段计算cpu使用率
float cpu_usage()
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}


@end
