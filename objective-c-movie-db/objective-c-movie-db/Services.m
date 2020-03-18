//
//  Services.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 18/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//
#import "Services.h"

@interface Services ()

@end

@implementation Services

    - (NSString *) getDataFrom:(NSString *)url{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
        [request setURL:[NSURL URLWithString:url]];

        NSError *error = nil;
        NSHTTPURLResponse *responseCode = nil;

        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
            return nil;
        }

        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }

@end
