//
//  HHZFPSLabel.h
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHZFPSLabel : UIView
-(void)modifyFPS:(CADisplayLink *)link;
@end

NS_ASSUME_NONNULL_END
