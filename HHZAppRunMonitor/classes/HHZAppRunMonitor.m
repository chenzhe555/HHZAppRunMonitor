//
//  HHZAppRunMonitor.m
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZAppRunMonitor.h"
#import <HHZCategory/NSTimer+HHZCategory.h>
#import "HHZFPSLabel.h"
#import "HHZCPULabel.h"
#import "HHZMemoryLabel.h"

//整体宽度
#define HHZAppRunMonitorWidth 160
//每个Item高度
#define HHZAppRunMonitorItemHeight 24

@interface HHZAppRunMonitor ()
@property (nonatomic, strong) NSArray * displayTypes;
@property (nonatomic, strong) HHZFPSLabel * fpsLabel;
@property (nonatomic, strong) HHZCPULabel * cpuLabel;
@property (nonatomic, strong) HHZMemoryLabel * memoryLabel;
@property (nonatomic, assign) BOOL firstShowState;

#pragma mark CADisplayLink和NSTimer结合使用，显示信息
@property (nonatomic, strong) CADisplayLink * displayLink;
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation HHZAppRunMonitor

+(instancetype)shareManager
{
    static HHZAppRunMonitor * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HHZAppRunMonitor alloc] init];
        UIWindow * window = [manager gainMainWindow];
        manager.frame = CGRectMake(window.bounds.size.width - HHZAppRunMonitorWidth, (window.bounds.size.height - 200)/2, HHZAppRunMonitorWidth, 200);
        manager.backgroundColor = [UIColor clearColor];
        [manager initialData];
    });
    return manager;
}

#pragma mark 初始化参数以及界面
-(void)initialData
{
    _displayTypes = @[@(HHZAppRunMonitorDisplayTypeFPS),@(HHZAppRunMonitorDisplayTypeCPU),@(HHZAppRunMonitorDisplayTypeMemory)];
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(showFront) userInfo:nil repeats:NO];
    
    [self createDisplayLink];
    [self createTimer];
    [self addNotification];
}

-(void)showFront
{
    [[self gainMainWindow] addSubview:self];
    [self addButtonOnstatusBar];
}

-(UIWindow *)gainMainWindow
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}


-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(fps_UIApplicationDidBecomeActiveNotification)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(fps_UIApplicationWillResignActiveNotification)
                                                 name: UIApplicationWillResignActiveNotification
                                               object: nil];
}

-(void)addButtonOnstatusBar
{
    UIView * foregroundView = [[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"];
    
    if (foregroundView)
    {
        for (UIView * vie in foregroundView.subviews)
        {
            if ([vie isKindOfClass:NSClassFromString(@"UIStatusBarTimeItemView")])
            {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                if (_firstShowState)
                {
                    [btn setTitle:@"关闭" forState:UIControlStateNormal];
                }
                else
                {
                    [btn setTitle:@"打开" forState:UIControlStateNormal];
                }
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                btn.frame = CGRectMake(vie.frame.origin.x - 30 - 5, 0, 30, 20);
                btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
                [btn addTarget:self action:@selector(clickShowButton:) forControlEvents:UIControlEventTouchUpInside];
                [foregroundView addSubview:btn];
            }
        }
    }
}


#pragma mark 创建CADisplayLink和NSTimer 以及相应方法
-(void)createDisplayLink
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runDisplayLink:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)createTimer
{
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer hhz_scheduledTimerWithTimeInterval:1.2f repeats:YES Block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) self = weakSelf;
        [self runTimer];
    }];
}

-(void)runDisplayLink:(CADisplayLink *)link
{
    [_fpsLabel modifyFPS:link];
}

-(void)runTimer
{
    [_cpuLabel modifyCPU];
    [_memoryLabel modifyMemory];
}

#pragma mark 创建需要显示的样式表
-(void)configShowTypes:(NSArray *)types
{
    _displayTypes = types;
}

-(void)generateMonitorShow:(BOOL)isShow
{
    if (_displayTypes.count == 0) return;
    
    HHZAppRunMonitorDisplayType type = HHZAppRunMonitorDisplayTypeFPS;
    
    CGFloat tmpY = 0;
    for (int i = 0; i < _displayTypes.count; ++i)
    {
        type = [_displayTypes[i] integerValue];
        if (type == HHZAppRunMonitorDisplayTypeFPS)
        {
            _fpsLabel = [[HHZFPSLabel alloc] initWithFrame:CGRectMake(0, tmpY, self.bounds.size.width, HHZAppRunMonitorItemHeight)];
            [self addSubview:_fpsLabel];
            tmpY += HHZAppRunMonitorItemHeight;
        }
        else if (type == HHZAppRunMonitorDisplayTypeCPU)
        {
            _cpuLabel = [[HHZCPULabel alloc] initWithFrame:CGRectMake(0, tmpY, self.bounds.size.width, HHZAppRunMonitorItemHeight)];
            [self addSubview:_cpuLabel];
            tmpY += HHZAppRunMonitorItemHeight;
        }
        else if (type == HHZAppRunMonitorDisplayTypeMemory)
        {
            _memoryLabel = [[HHZMemoryLabel alloc] initWithFrame:CGRectMake(0, tmpY, self.bounds.size.width, HHZAppRunMonitorItemHeight)];
            [self addSubview:_memoryLabel];
            tmpY += HHZAppRunMonitorItemHeight;
        }
    }
    self.frame = CGRectMake([self gainMainWindow].bounds.size.width - HHZAppRunMonitorWidth, ([self gainMainWindow].bounds.size.height - tmpY)/2, HHZAppRunMonitorWidth, tmpY);
    
    _firstShowState = isShow;
    self.hidden = !_firstShowState;
}

#pragma mark 顶部按钮点击事件
-(void)clickShowButton:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"关闭"])
    {
        [btn setTitle:@"打开" forState:UIControlStateNormal];
        [self modifyMonitorStatus:NO];
    }
    else
    {
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        [self modifyMonitorStatus:YES];
    }
}

-(void)modifyMonitorStatus:(BOOL)isShow
{
    self.hidden = !isShow;
}

#pragma mark 触摸事件
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:[self gainMainWindow]];
    self.center = point;
}

#pragma mark App处于前后台通知事件
-(void)fps_UIApplicationDidBecomeActiveNotification
{
    [_displayLink setPaused:NO];
    [_timer resumeTimer];
}

-(void)fps_UIApplicationWillResignActiveNotification
{
    [_displayLink setPaused:YES];
    [_timer pauseTimer];
}

-(void)dealloc
{
    [_displayLink setPaused:YES];
    [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_timer invalidate];
    _timer = nil;
    _displayLink = nil;
}

@end
