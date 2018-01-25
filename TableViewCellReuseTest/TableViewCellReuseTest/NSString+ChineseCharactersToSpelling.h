//
//  NSString+ChineseCharactersToSpelling.h
//  UniteRoute
//
//  Created by zz on 2016/11/19.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ChineseCharactersToSpelling)
+(NSString *)lowercaseSpellingWithChineseCharacters:(NSString *)chinese;
@end
