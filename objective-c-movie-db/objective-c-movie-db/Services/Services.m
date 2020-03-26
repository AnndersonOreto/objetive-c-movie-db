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

@interface Services () {
    NSCache<NSString*, UIImage *> *cache;
}

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

- (instancetype)init {
    
    if (self) {
        
        self.popularMoviesURL = @"https://api.themoviedb.org/3/movie/now_playing?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US&page=1";
        self.nowPlayingURL = @"https://api.themoviedb.org/3/movie/popular?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US&page=1";
        cache = [NSCache<NSString*, UIImage *> new];
    }
    
    return self;
}

#pragma mark - API request functions

// Fetch data from API of popular movies
- (void)getPopularMovies:(void (^)(NSMutableArray *))completionHandler {
    
    // Popular movies URL
    NSString *urlString = _popularMoviesURL;
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
    NSString *urlString = _nowPlayingURL;
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

- (void)getGenre:(NSString *)movieId completion:(void (^)(NSString *))completionHandler {
    
    NSString *baseURL1 = @"https://api.themoviedb.org/3/movie/\\";
    NSString *baseURL2 = @"?api_key=46fc18b76e16ff3966bbb4390154e35e&language=en-US";
    NSString *resultURL = [NSString stringWithFormat: @"%@%@%@", baseURL1, movieId, baseURL2];
    NSURL *url = [NSURL URLWithString:resultURL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if (error) {
            return;
        }
        
        NSArray *moviesArray = JSON[@"genres"];
        NSString *genres = NSString.new;
        Parser *parser = Parser.new;
        
        genrers = [parser parseGenders:moviesArray];
        
        completionHandler(genres);
        
    }] resume];
}

// Return image from API
- (void)getImage:(NSString *)imageName completion:(void (^)(UIImage *))completionHandler {
    
    NSString *base_url = @"https://image.tmdb.org/t/p/w500";
    NSString *imagePath = [NSString stringWithFormat: @"%@%@", base_url, imageName];
    NSURL *url = [NSURL URLWithString:imagePath];
    UIImage *image = [cache objectForKey:imagePath];
    
    // If image is not in cache
    if (image == nil) {
        
        [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                return;
            }
            
            // Build image from fetched data
            UIImage *image = [UIImage imageWithData:data];
            [self->cache setObject: image forKey:imagePath];
            
            completionHandler([self->cache objectForKey:imagePath]);
            
        }] resume];
    } else {
        
        completionHandler([cache objectForKey:imagePath]);
    }
}

- (void)loadImage:(NSString *)imageName completion:(void (^)(UIImage *))completionHandler {
    
    NSMutableString *baseImageUrl = [NSMutableString stringWithString:@"https://image.tmdb.org/t/p/w500"];
    NSString *imageURL = [baseImageUrl stringByAppendingString:imageName];
    
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
        
        if ( data == nil ) return;
        
        UIImage *image = [UIImage imageWithData:data];
        completionHandler(image);
    });
}

@end
