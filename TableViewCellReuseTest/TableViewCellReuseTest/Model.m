//
//  Model.m
//  UniteRoute
//
//  Created by Li on 16/9/26.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Model.h"
@implementation Model
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        if ([dic isKindOfClass:[NSNull class]]||dic.count==0) {
            return nil;
        }
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
//- (void)setValue:(id)value forKey:(NSString *)key {
//    if (![value isKindOfClass:[NSNull class]]&&value) {
//        [super setValue:value forKey:key];
//    }
//}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
