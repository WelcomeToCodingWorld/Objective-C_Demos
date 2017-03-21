//
//  UnitTestDemoTestsTests.m
//  UnitTestDemoTestsTests
//
//  Created by zz on 2016/10/24.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#define WAIT do {\
[self expectationForNotification:@"RSBaseTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);

#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"RSBaseTest" object:nil];
#import <XCTest/XCTest.h>
#import <AFNetworking.h>

@interface UnitTestDemoTestsTests : XCTestCase

@end

@implementation UnitTestDemoTestsTests
{
    int statusCode;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    statusCode = -1;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"自定义测试testExample");
    int a = 3;
    XCTAssertTrue(a == 3,@"a不能等于0");
    
    bool t1 =-8;//true or false
    BOOL t2 = -10;//YES or NO
    Boolean t3 = -1; //unsigned char type
    boolean_t t4 = -3;//int type
    NSAssert(t1,@"bool t1 is NO");//通过测试
    NSAssert(t2,@"BOOL t2 is NO");//通过测试
    NSAssert(t3,@"Boolean t3 is NO");//通过测试
    NSAssert(t4,@"boolean_t t4 is NO");//通过测试
}

- (void)testRequest {
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        int sum = 0;
        for (int i = 0; i < 1000; i ++) {
            sum += i;
        }
    }];
}

@end
