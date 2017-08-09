//
//  HHZAppRunMonitor.h
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HHZAppRunMonitorDisplayType) {
    HHZAppRunMonitorDisplayTypeFPS = 10010,
    HHZAppRunMonitorDisplayTypeCPU
};

NS_ASSUME_NONNULL_BEGIN

@interface HHZAppRunMonitor : UIView
/**
 *  获取实例
 */
+(instancetype)shareManager;

/**
 *  生成并显示监视器
 */
-(void)generateMonitor;
@end

NS_ASSUME_NONNULL_END
