//
//  Parser.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 24/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import "Parser.h"
#import "Movie.h"

@implementation Parser

#pragma mark - Atomic parsers

// Parse atomic movie into a Movie object
- (Movie *) parseMovie:(NSDictionary *)dictionary {
    
    // Collect all parameters form JSON in dictionary
    NSString *title = dictionary[@"title"];
    NSString *overview = dictionary[@"overview"];
    NSNumber *rating = dictionary[@"vote_average"];
    NSString *imageUrl = dictionary[@"poster_path"];
    NSString *movieId = dictionary[@"id"];
    
    // Create object with information
    Movie *movie = Movie.new;
    
    movie.movieTitle = title;
    movie.movieDescription = overview;
    movie.movieRating = rating;
    movie.movieImage = imageUrl;
    movie.movieId = movieId;
    
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

- (NSString *) parseGenres:(NSArray *)array {
    
    NSString *genres = @"";
    NSMutableString *resp = NSMutableString.new;
    
    for (NSDictionary *dict in array) {
        [resp appendString:dict[@"name"]];
    }
    
    genres = resp;
    
    return genres;
}

@end
