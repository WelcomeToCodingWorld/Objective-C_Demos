//
//  ViewController.h
//  OCInterJS
//
//  Created by zz on 2016/11/2.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol ObjecExportMethod;
@interface ViewController : UIViewController
@end


@protocol ObjecExportMethod<JSExport>
JSExportAs(showNumber,- (void)showNumber1:(NSNumber*)n1 andNumber2:(NSNumber*)n2);

JSExportAs(returnSum, - (NSNumber*)returnSumWithNum1:(NSNumber*)n1 andNum2:(NSNumber*)n2);

JSExportAs(dictTest,
           - (void)dictTest:(NSDictionary *)dict
           );

JSExportAs(arrayTest,
           - (void)arrayTest:(NSArray *)array
           );

- (void)show;
- (NSString *)returnString;
- (NSDictionary *)returnDict;
- (NSArray *)returnArray;
@end
