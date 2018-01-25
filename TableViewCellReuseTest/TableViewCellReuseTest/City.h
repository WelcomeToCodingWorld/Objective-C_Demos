//
//  City.h
//  UniteRoute
//
//  Created by zz on 2016/10/18.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Model.h"
@class Area;
@interface City : Model
@property (nonatomic,copy)NSString* code;
@property (nonatomic,copy)NSString* name;
@property (nonatomic,copy)NSString* lowerCase;
- (instancetype)initWithCode:(NSString*)code name:(NSString*)name;
@property (nonatomic,copy)NSString* provinceCode;
@property (nonatomic,assign)NSInteger leves;
@property (nonatomic,strong) NSArray<Area*> *areas;
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,assign)BOOL showTopLine;
@end

@interface Area : Model
@property (nonatomic,copy)NSString* code;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString* lowerCase;
- (instancetype)initWithCode:(NSString*)code name:(NSString*)name;
@property (nonatomic,assign)NSInteger leves;
@property (nonatomic,copy)NSString* cityCode;
@end

@interface Province:Model
@property (nonatomic,copy)NSString* name;
@property (nonatomic,copy)NSString* code;
@property (nonatomic,copy)NSString* lowerCase;
@property (nonatomic,copy)NSArray<City*>* cities;
- (instancetype)initWithCode:(NSString*)code name:(NSString*)name;
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,assign)BOOL showTopLine;
@end
