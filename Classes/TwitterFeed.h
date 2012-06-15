//
//  TwitterFeed.h
//  ISQua
//
//  Created by Newro Mac on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwitterFeed : NSObject {
	NSString *titleT;
	NSString *dateT;
    NSString *link;

}

@property (nonatomic, retain) NSString *titleT;
@property (nonatomic, retain) NSString *dateT;
@property (nonatomic, retain) NSString *link;

@end
