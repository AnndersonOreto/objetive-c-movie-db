//
//  Movie.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 19/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)parseDictionary:(NSDictionary *)dictionary {
    
    if (self) {
        
        NSString *title = dictionary[@"title"];
        NSString *overview = dictionary[@"overview"];
        NSNumber *rating = dictionary[@"vote_average"];
        NSString *imageUrl = dictionary[@"poster_path"];

        
        self.movieTitle = title;
        self.movieDescription = overview;
        self.movieRating = rating;
        self.movieImage = imageUrl;
    }
    
    return self;
}

@end
