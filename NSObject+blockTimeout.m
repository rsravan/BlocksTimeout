//
//  NSObject+blockTimeout.m
//  BlocksTimeout
//
//  Created by SRAVAN on 4/29/13.
//  Copyright (c) 2013 SRAVAN. All rights reserved.
//

#import "NSObject+blockTimeout.h"

#include <mach/mach.h>

#include <stdint.h>

#include <mach/mach_time.h>

@implementation NSObject (blockTimeout)

-(void)performOperation:(void (^)(void))block onqueue:(dispatch_queue_t)queue withtimeOut:(double_t)timeout {
    
    //Block  or queue is nil return immediately
    if (!block || !queue) {
        return;
    }
    
    dispatch_retain(queue);
    
    Block_copy(block);
    
    const uint64_t startTime = mach_absolute_time();         //Time when the block is called

    __block double_t blockTimeout=timeout;
    
    void(^wrapperBlock)(void)=^{
      
        uint64_t endTime=mach_absolute_time(); ;            //time when the block starts executing
        
        const uint64_t elapsedMTU = endTime - startTime;   //elapsed time in MTU
        
        mach_timebase_info_data_t info;
        
        mach_timebase_info(&info);
        
        const double elapsedMS = (double)1e-6 * (double)elapsedMTU * (double)info.numer / (double)info.denom;
        
        NSLog(@"%f",elapsedMS);
        
        NSLog(@"%f",(double)blockTimeout);
        
        if (elapsedMS>(double)blockTimeout) {
            
            NSLog(@"Block timed out");
            
            return;
        }
        else
            block();
        
    };
     
    dispatch_async(queue,^{
        
        wrapperBlock();
        
        Block_release(block);
    });
        
    dispatch_release(queue);
    
}



@end
