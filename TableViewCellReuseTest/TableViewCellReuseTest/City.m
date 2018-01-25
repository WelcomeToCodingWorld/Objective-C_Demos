//
//  City.m
//  UniteRoute
//
//  Created by zz on 2016/10/18.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "City.h"
#import "NSString+ChineseCharactersToSpelling.h"
@implementation Province

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"data"]) {
        NSMutableArray *tmpArr = @[].mutableCopy;
        for (NSDictionary* cityDic in value) {
            City *city = [[City alloc]initWithDic:cityDic];
            city.provinceCode = self.code;
            [tmpArr addObject:city];
        }
        self.cities = tmpArr;
    }
}

- (NSString *)lowerCase {
    if (!_lowerCase) {
        _lowerCase = [NSString lowercaseSpellingWithChineseCharacters:self.name];
    }
    return  _lowerCase;
}

- (instancetype)initWithCode:(NSString*)code name:(NSString*)name {
    self = [super init];
    if (self) {
        self.code = code;
        self.name = name;
    }
    return self;
}

@end

@implementation City
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{//区县
    if ([key isEqualToString:@"data"]) {
        NSMutableArray *tmpArr = @[].mutableCopy;
        for (NSDictionary* areaOrCounty in value) {
            Area *area = [[Area alloc]initWithDic:areaOrCounty];
            area.cityCode = self.code;
            [tmpArr addObject:area];
        }
        _areas = tmpArr;
    }
}

- (NSString *)lowerCase {
    if (!_lowerCase) {
        _lowerCase = [NSString lowercaseSpellingWithChineseCharacters:self.name];
    }
    return  _lowerCase;
}



- (instancetype)initWithCode:(NSString*)code name:(NSString*)name {
    self = [super init];
    if (self) {
        self.code = code;
        self.name = name;
    }
    return self;
}


- (NSArray<Area*> *)areas {
    if (!_areas) {
        _areas = [self.areas sortedArrayUsingComparator:^NSComparisonResult(Area*  _Nonnull obj1, Area*  _Nonnull obj2) {
            return [obj1.lowerCase compare:obj2.lowerCase] == NSOrderedDescending;
        }];
    }
    return _areas;
}
@end

@implementation Area
- (instancetype)initWithCode:(NSString*)code name:(NSString*)name {
    self = [super init];
    if (self) {
        self.code = code;
        self.name = name;
    }
    return self;
}

- (NSString *)lowerCase {
    if (!_lowerCase) {
        _lowerCase = [NSString lowercaseSpellingWithChineseCharacters:self.name];
    }
    return  _lowerCase;
}

@end
