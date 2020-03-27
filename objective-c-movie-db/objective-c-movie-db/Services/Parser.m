//
//  Parser.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 24/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import "Parser.h"
#import "Movie.h"
#import "Services.h"

@interface Parser () {
    Services *service;
}

@end

@implementation Parser

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        service = Services.new;
    }
    return self;
}

#pragma mark - Atomic parsers

// Parse atomic movie into a Movie object
- (Movie *) parseMovie:(NSDictionary *)dictionary {
    
    // Collect all parameters form JSON in dictionary
    NSString *title = dictionary[@"title"];
    NSString *overview = dictionary[@"overview"];
    NSNumber *rating = dictionary[@"vote_average"];
    NSString *imageUrl = dictionary[@"poster_path"];
    NSString *movieId = dictionary[@"id"];
    NSMutableString *genreList = NSMutableString.new;
    
        [service getGenre:movieId completion:^(NSArray * genre) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (NSDictionary *genreName in genre) {
                    [genreList appendFormat:@"%@, ", genreName[@"name"]];
                }
            });
        }];\
    
    // Create object with information
    Movie *movie = Movie.new;
    
    movie.movieTitle = title;
    movie.movieDescription = overview;
    movie.movieRating = rating;
    movie.movieImage = imageUrl;
    movie.movieId = movieId;
    movie.genres = genreList;
    
    return movie;
}

#pragma mark - Array parsers

// Parse array of movies into an NSMutableArray of Movie objects
- (NSMutableArray<Movie*> *) parseArray:(NSArray *)array {
    
    // Create movies array
    NSMutableArray<Movie*> *movies = NSMutableArray.new;
    
    // For eachJSON in array parse it into Movie object
    for (NSDictionary *movieDict in array) {
        
        // Add each Movie into the array
        Movie *movie = [self parseMovie:movieDict];
        [movies addObject:movie];
        
    }
    
    return movies;
}

// Parse genders
- (NSString *) parseGenres:(NSArray *)array {
    
    // Initialize genre string
    NSString *genres = @"";
    NSMutableString *resp = NSMutableString.new;
    
    // Concatenate genres
    for (NSDictionary *dict in array) {
        [resp appendString:dict[@"name"]];
    }
    
    genres = resp;
    
    return genres;
}

@end
