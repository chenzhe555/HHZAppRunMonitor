//
//  NSDictionary+HHZCategory.m
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import "NSDictionary+HHZCategory.h"

#pragma mark ----------->NSDictionary

@implementation NSDictionary (HHZ_Log)

-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString * mutaStr = [NSMutableString stringWithString:[NSString stringWithFormat:@"\n %p {\n",self]];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mutaStr appendFormat:@"%@(%@) = \n\t\t\t%@;\n" ,key,[obj class], obj];
    }];
    
    [mutaStr appendString:@"}\n"];
    
    return mutaStr;
}

-(NSArray *)hhz_allSortedKeys
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

@end





#pragma mark ----------->NSMutableDictionary
@implementation NSMutableDictionary (HHZ_Insert)

-(void)hhz_setObject:(id)aObject key:(id<NSCopying>)aKey
{
    if (aKey)
    {
        if (aObject)
        {
            [self setObject:aObject forKey:aKey];
        }
        else
        {
            [self setObject:[NSNull null] forKey:aKey];
        }
    }
}


@end
