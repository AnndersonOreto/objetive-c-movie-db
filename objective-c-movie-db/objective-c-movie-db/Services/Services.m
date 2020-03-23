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

- (void)getPopularMovies:(void (^)(NSMutableArray *))completionHandler {
    NSString *urlString = @"https://api.themoviedb.org/3/movie/now_playing?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *parsedJSON2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
            if (err) {
                NSLog(@"Failed to serialize data into JSON: %@", err);
                return;
            }
            
            self.popularMovies = NSMutableArray.new;
            
            NSArray *moviesArray = parsedJSON2[@"results"];
            for (NSDictionary *movieDictionary in moviesArray) {
                Movie *movie = Movie.new;
                movie = [movie parseDictionary:movieDictionary];
                [self.popularMovies addObject:movie];
                
            }
        
            completionHandler(self.popularMovies);
        
        
    }] resume];
    
}

- (void)getNowPlaying:(void (^)(NSMutableArray *))completionHandler {
    NSString *urlString = @"https://api.themoviedb.org/3/movie/popular?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *parsedJSON2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
            if (err) {
                NSLog(@"Failed to serialize data into JSON: %@", err);
                return;
            }
            
            self.nowPlayingMovies = NSMutableArray.new;
            
            NSArray *moviesArray = parsedJSON2[@"results"];
            for (NSDictionary *movieDictionary in moviesArray) {
                Movie *movie = Movie.new;
                movie = [movie parseDictionary:movieDictionary];
                [self.nowPlayingMovies addObject:movie];
                
            }
        
            completionHandler(self.nowPlayingMovies);
        
        
    }] resume];
    
}

@end
