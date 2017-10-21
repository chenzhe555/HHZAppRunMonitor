//
//  NSNotificationCenter+Category.m
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/24.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import "NSNotificationCenter+Category.h"

@implementation NSNotificationCenter (HHZ_OnMainThread)

-(void)hhz_postNotificationOnMainThreadWithName:(NSString *)name Object:(id)object UserInfo:(NSDictionary *)userInfo WaitUntilDone:(BOOL)wait
{
    //校验参数
    if (!name) return;
    //如果在主线程，则什么都不做
    if ([NSThread mainThread]) return [self postNotificationName:name object:object userInfo:userInfo];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic setObject:name forKey:@"name"];
    if (object) [dic setObject:object forKey:@"object"];
    if (userInfo) [dic setObject:userInfo forKey:@"userInfo"];
    
    //在主线程执行通知
    [self performSelectorOnMainThread:@selector(postDefineParameterOnMainThread:) withObject:dic waitUntilDone:wait];
}

-(void)postDefineParameterOnMainThread:(NSMutableDictionary *)dic
{
    [[NSNotificationCenter defaultCenter] postNotificationName:dic[@"name"] object:dic[@"object"] userInfo:dic[@"userInfo"]];
}

@end
