//
//  GooglyPuffTests.m
//  GooglyPuffTests
//
//  Created by ycpjobs on 16/4/3.
//  Copyright © 2016年 ycpjobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Photo.h"
#import <Foundation/Foundation.h>

@interface GooglyPuffTests : XCTestCase

@end

@implementation GooglyPuffTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


-(void)downloadImageURLWithString:(NSString *)URLString
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURL *url = [NSURL URLWithString:URLString];
    __unused Photo *photo = [[Photo alloc] initwithURL:url withCompletionBlock:^(UIImage *image, NSError *error) {
        if (error) {
            XCTFail(@"%@ failed. %@", URLString, error);
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, 1);
    if (dispatch_semaphore_wait(semaphore, timeoutTime)) {
        XCTFail(@"%@ timed out", URLString);
    }
}
@end
