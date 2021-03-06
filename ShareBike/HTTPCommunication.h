//
//  HTTPCommunication.h
//  ShareBike
//
//  Created by tho dang on 2015-05-07.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPCommunication : NSObject<NSURLSessionDownloadDelegate>

// successBlock will contain the block you're going to call when the request is completed

@property (copy,nonatomic) void (^successBlock)(NSData *);

// Craft and request using NSURLRequest and NSURLConnection

- (void) retrieveURL:(NSURL *)url
        successBlock:(void (^)(NSData *))successBlock;

// Task has finished downloading delegate  method

-(void)URLSession           :(NSURLSession *)session
                downloadTask:(NSURLSessionDownloadTask *)downloadTask
   didFinishDownloadingToURL:(NSURL *)location;


@end

