//
//  Parser.h
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 24/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface Parser : NSObject

#pragma mark - Functions

- (Movie *) parseMovie:(NSDictionary *)dictionary;
- (NSMutableArray<Movie*> *) parseArray:(NSArray *)array;

@end
