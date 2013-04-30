//
//  NSObject+blockTimeout.h
//  BlocksTimeout
//
//  Created by SRAVAN on 4/29/13.
//  Copyright (c) 2013 SRAVAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(blockTimeout){
    
}


//*params
//queue on to which the block is dispatched
//block-block to be executed with params
//timeout-timeout in milliseconds

-(void)performOperation:(void (^)(void))block onqueue:(dispatch_queue_t)queue  withtimeOut:(double_t)timeout;

@end
