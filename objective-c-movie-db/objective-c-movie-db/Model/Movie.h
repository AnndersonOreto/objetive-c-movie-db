//
//  Movie.h
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 19/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import  <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

#pragma mark - Variables

@property (nonatomic, strong) NSString *movieTitle;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSNumber *movieRating;
@property (nonatomic, strong) NSString *movieImage;
@property (nonatomic, strong) NSString *movieId;
@property (nonatomic, strong) NSString *genres;

@end

NS_ASSUME_NONNULL_END
