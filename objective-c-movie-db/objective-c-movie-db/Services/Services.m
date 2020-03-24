//
//  Services.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 18/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//
#import "Services.h"
#import "Movie.h"
#import "Parser.h"

@interface Services ()

@end

@implementation Services

#pragma mark - Singleton

// Creating singleton
/*
+ (instancetype)sharedInstance {
    
    // Static variable of Services class
    static Services *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    // Initializing class once
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[Services alloc] init];
    });
    
    return sharedInstance;
}
*/

#pragma mark - API request functions

// Fetch data from API of popular movies
- (void)getPopularMovies:(void (^)(NSMutableArray *))completionHandler {
    
    // Popular movies URL
    NSString *urlString = @"https://api.themoviedb.org/3/movie/now_playing?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Start session to retrieve JSON from data
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Extracting JSON from data
        NSError *err;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        // Error handler
        if (err) {
            NSLog(@"Failed to serialize data into JSON: %@", err);
            return;
        }
        
        // Getting results from key results
        NSArray *moviesArray = JSON[@"results"];
        NSMutableArray<Movie*> *movies = NSMutableArray.new;
        Parser *parser = Parser.new;
        
        // Using Parser object to parse JSON into Movie objects
        movies = [parser parseArray:moviesArray];
        
        // Finishing execution
        completionHandler(movies);
        
        
    }] resume];
    
}

// Fetch data from API of now playing movies
- (void)getNowPlaying:(void (^)(NSMutableArray *))completionHandler {
    
    // Now playing URL
    NSString *urlString = @"https://api.themoviedb.org/3/movie/popular?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Start session to retrieve JSON from data
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Extracting JSON from data
        NSError *err;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        // Error handler
        if (err) {
            NSLog(@"Failed to serialize data into JSON: %@", err);
            return;
        }
        
        // Getting results from key results
        NSArray *moviesArray = JSON[@"results"];
        NSMutableArray<Movie*> *movies = NSMutableArray.new;
        Parser *parser = Parser.new;
        
        // Using Parser object to parse JSON into Movie objects
        movies = [parser parseArray:moviesArray];
        
        // Finishing execution
        completionHandler(movies);
        
        
    }] resume];
    
}

@end
