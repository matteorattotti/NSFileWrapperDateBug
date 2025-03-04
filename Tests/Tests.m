//
//  Tests.m
//  Tests
//
//  Created by Matteo Rattotti on 04/03/25.
//

#import <XCTest/XCTest.h>

@interface Tests : XCTestCase

@end

@implementation Tests


/// If a file is overwritten with the same content using -[NSFileWrapper writeToURL:options:originalContentsURL:error:], its modification date is sometimes set to a past timestamp after the write.
- (void)testWriteFile
{
    for (int i = 0; i<=10; i++) {
        NSURL *textFileURL = [NSURL fileURLWithPath: [NSTemporaryDirectory() stringByAppendingPathComponent:[NSUUID UUID].UUIDString]];
        
        [@"test file" writeToURL:textFileURL atomically:NO encoding:NSUTF8StringEncoding error:nil];
        
        NSFileManager *fm = NSFileManager.defaultManager;
        
        NSDate *dateBeforeRewrite = [[fm attributesOfItemAtPath:textFileURL.path error:nil] fileModificationDate];
                
        NSFileWrapper *fw = [[NSFileWrapper alloc] initWithURL:textFileURL options:0 error:nil];
        [fw writeToURL:textFileURL options:0 originalContentsURL:nil error:nil];
        
        NSDate *dateAfterRewrite = [[fm attributesOfItemAtPath:textFileURL.path error:nil] fileModificationDate];
        
        NSComparisonResult res = [dateBeforeRewrite compare:dateAfterRewrite];
        
        XCTAssertTrue(res != NSOrderedDescending);
        
        [[NSFileManager defaultManager] removeItemAtURL:textFileURL error:nil];
    }
}

@end
