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
    HHZAppRunMonitorDisplayTypeCPU,
    HHZAppRunMonitorDisplayTypeMemory
};

NS_ASSUME_NONNULL_BEGIN

@interface HHZAppRunMonitor : UIView
#pragma mark required
/**
 *  获取单例
 */
+(instancetype)shareManager;

/**
 *  生成并显示监视器,YES代表显示，NO代表暂时不显示
 */
-(void)generateMonitorShow:(BOOL)isShow;



#pragma mark optional
/**
 *  配置自己需要显示的几种类型，在generateMonitor之前执行
 */
-(void)configShowTypes:(NSArray *)types;
@end

NS_ASSUME_NONNULL_END
