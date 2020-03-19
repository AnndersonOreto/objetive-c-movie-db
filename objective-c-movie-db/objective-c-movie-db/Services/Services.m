//
//  Services.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 18/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//
#import "Services.h"
#import "Movie.h"

@interface Services ()

@end

@implementation Services

- (NSMutableArray*)getPopularMovies {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    // insert whatever URL you would like to connect to
    [request setURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US&page=1"]];
    
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^( NSData *data, NSURLResponse *response, NSError *error )
    {
        dispatch_async( dispatch_get_main_queue(),
        ^{
             NSError *jsonError;
             NSDictionary *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
             
             NSLog( @"%@", parsedJSONArray );
            
            NSArray *movies = parsedJSONArray[@"results"];
            for (NSDictionary *movieDictionary in movies) {
                Movie *movie = Movie.new;
                movie = [movie parseDictionary:movieDictionary];
                
                [self.popularMovies addObject:movie];
            }
            // parse returned data
            //NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            //NSLog( @"%@", result );
        } );
      
    }];
    
    [task resume];
    
    return _popularMovies;
}

- ( NSURLSession * )getURLSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
    ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration];
    } );
    
    return session;
}

@end
