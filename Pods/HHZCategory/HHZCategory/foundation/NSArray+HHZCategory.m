//
//  NSArray+HHZCategory.m
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import "NSArray+HHZCategory.h"
#import <objc/runtime.h>

#pragma mark NSArray

@implementation NSArray (HHZ_Log)

-(nullable NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString * mutaStr = [NSMutableString stringWithString:[NSString stringWithFormat:@"\n %p (\n",self]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mutaStr appendFormat:@"%lu(%@):\n\t%@\n", (unsigned long)idx,[obj class],obj];
    }];
    
    [mutaStr appendString:@")"];
    
    return mutaStr;
}

-(id)hhz_objectAtIndex:(NSInteger)index
{
    return (index >= 0 && index < self.count) ? self[index] : nil;
}

@end


@implementation NSArray (HHZ_Check)

-(instancetype)hhz_check
{
    if (![self isKindOfClass:[NSArray class]])
    {
        return [NSArray array];
    }
    return self;
}

@end




#pragma mark NSMutableArray

@implementation NSMutableArray (HHZ_CRUD)

-(void)hhz_removeFirstObject
{
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

-(void)hhz_removeLastObject
{
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

-(void)hhz_insertArray:(NSArray *)arr atIndex:(NSUInteger)index
{
    for (id obj in arr)
    {
        [self insertObject:obj atIndex:index++];
    }
}

-(void)hhz_reverseArray
{
    NSUInteger arrCount = self.count;
    NSUInteger arrMiddle = floor(arrCount / 2.0);
    //二分
    for (NSUInteger i = 0;i < arrMiddle;++i)
    {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(arrCount - (i + 1))];
    }
}

@end
