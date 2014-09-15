//
//  RestKITLibraryTests.m
//  RestKITLibraryTests
//
//  Created by ronnymeissner on 08/14/2014.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

SpecBegin(InitialSpecs)


describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd
