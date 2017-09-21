//
//  ViewController.m
//  HockeyLeague
//
//  Created by Larivière, Maxime on 17-09-14.
//  Copyright © 2017 Larivière, Maxime, Croteau, Samuel, Laroche, Samuel, Pérami, Kian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)NewGameButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *teamA;
@property (weak, nonatomic) IBOutlet UILabel *teamB;

@property (weak, nonatomic) IBOutlet UILabel *playerA1;
@property (weak, nonatomic) IBOutlet UILabel *playerA2;
@property (weak, nonatomic) IBOutlet UILabel *playerA3;
@property (weak, nonatomic) IBOutlet UILabel *playerA4;
@property (weak, nonatomic) IBOutlet UILabel *playerA5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)NewGameButton:(UIButton *)sender {
    UIAlertController* setTeamA = [UIAlertController
                                        alertControllerWithTitle: @"Nouvelle Partie - Équipe maison"
                                        message: @"Veuillez entrer le nom et numéro des joueur de l'équipe"
                                        preferredStyle:UIAlertControllerStyleAlert];
    
    //Nom de l'équipe
    [setTeamA addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Équipe";
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    for (int i = 1; i < 6; i++) {
        [setTeamA addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = [NSString stringWithFormat:@"Numéro - Prénom Nom du Joueur %d", i];
            textField.textColor = [UIColor blackColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }];
    }
    [setTeamA addAction:[UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
//                             NSArray* input = setTeamA.textFields;
//                             
//                             _teamA.text = input[0];
//                             _playerA1.text = input[1];
//                             _playerA2.text = input[2];
//                             _playerA3.text = input[3];
//                             _playerA4.text = input[4];
//                             _playerA5.text = input[5];
                             
                         }]];
    [self presentViewController:setTeamA animated:YES completion:nil];
    
}
@end

