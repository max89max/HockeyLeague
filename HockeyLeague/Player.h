//
//  Player.h
//  HockeyLeague
//
//  Created by Larivière, Maxime on 17-10-04.
//  Copyright © 2017 Larivière, Maxime, Croteau, Samue;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
{
    
}

@property NSString *prenom;
@property NSString *nom;
@property NSString *numero;
@property int but;
@property int passe;
@property int score;

- (Player*)initPlayer: (NSString *)prenom_ nom:(NSString *)nom_ numero:(NSString *)numero_;

@end
