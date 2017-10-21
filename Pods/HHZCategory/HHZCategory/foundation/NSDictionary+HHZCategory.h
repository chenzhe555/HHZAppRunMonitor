//
//  NSDictionary+HHZCategory.h
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark ----------->NSDictionary
@interface NSDictionary (HHZ_Log)

/**
 *  由于服务器返回的打印出来不是UTF-8格式，不易查看，于是重写NSDictionary打印的description方法，打印的时候能很清楚看到中文字符
 *
 *  @param locale
 *
 *  @return
 */
-(NSString *)descriptionWithLocale:(id)locale;

/**
 *  不区分大小，输出排序后的Key
 *
 *  @return 排序后的Key
 */
-(nullable NSArray *)hhz_allSortedKeys;

@end






#pragma mark ----------->NSMutableDictionary

@interface NSMutableDictionary (HHZ_Insert)
/**
 *  如果Object为空，默认往字典中塞入Null对象
 *
 *  @param anObject 存储的数据
 *  @param aKey     key值
 */
-(void)hhz_setObject:(nullable id)aObject key:(nullable id<NSCopying>)aKey;
@end

NS_ASSUME_NONNULL_END
