//
//  Player.m
//  HockeyLeague
//
//  Created by Larivière, Maxime on 17-10-04.
//  Copyright © 2017 Larivière, Maxime, Croteau, Samue;. All rights reserved.
//

#import "Player.h"

@implementation Player
{
    
}

- (Player*)initPlayer: (NSString *)prenom_ nom:(NSString *)nom_ numero:(NSString *)numero_
{
    self = [super init];
    if (self) {
        // Initialize self
        self.prenom = prenom_;
        self.nom = nom_;
        self.numero = numero_;
    }
    return self;
}

@end
