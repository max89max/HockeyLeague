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
- (IBAction)ChangePeriod:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *teamA;
@property (weak, nonatomic) IBOutlet UILabel *teamB;

@property (weak, nonatomic) IBOutlet UILabel *playerA1;
@property (weak, nonatomic) IBOutlet UILabel *playerA2;
@property (weak, nonatomic) IBOutlet UILabel *playerA3;
@property (weak, nonatomic) IBOutlet UILabel *playerA4;
@property (weak, nonatomic) IBOutlet UILabel *playerA5;
@property (weak, nonatomic) IBOutlet UILabel *playerB1;
@property (weak, nonatomic) IBOutlet UILabel *playerB2;
@property (weak, nonatomic) IBOutlet UILabel *playerB3;
@property (weak, nonatomic) IBOutlet UILabel *playerB4;
@property (weak, nonatomic) IBOutlet UILabel *playerB5;

@property (weak, nonatomic) IBOutlet UILabel *period;

@end

@implementation ViewController

int periodCounter = 1;

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
    //Nom des joueur
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
                             NSArray<UITextField *> *input = setTeamA.textFields;
                             
                             _teamA.text = [NSString stringWithFormat:@"Équipe - %@", input[0].text];
                             _playerA1.text = input[1].text;
                             _playerA2.text = input[2].text;
                             _playerA3.text = input[3].text;
                             _playerA4.text = input[4].text;
                             _playerA5.text = input[5].text;
                             
                             UIAlertController* setTeamB = [UIAlertController
                                                            alertControllerWithTitle: @"Nouvelle Partie - Équipe visiteur"
                                                            message: @"Veuillez entrer le nom et numéro des joueur de l'équipe"
                                                            preferredStyle:UIAlertControllerStyleAlert];
                             
                             //Nom de l'équipe
                             [setTeamB addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                                 textField.placeholder = @"Équipe";
                                 textField.textColor = [UIColor blackColor];
                                 textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                                 textField.borderStyle = UITextBorderStyleRoundedRect;
                             }];
                             //Nom des joueur
                             for (int i = 1; i < 6; i++) {
                                 [setTeamB addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                                     textField.placeholder = [NSString stringWithFormat:@"Numéro - Prénom Nom du Joueur %d", i];
                                     textField.textColor = [UIColor blackColor];
                                     textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                                     textField.borderStyle = UITextBorderStyleRoundedRect;
                                 }];
                             }
                             [setTeamB addAction:[UIAlertAction
                                                  actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction *action) {
                                                      NSArray<UITextField *> *input = setTeamB.textFields;
                                                      
                                                      _teamB.text = [NSString stringWithFormat:@"Équipe - %@", input[0].text];
                                                      _playerB1.text = input[1].text;
                                                      _playerB2.text = input[2].text;
                                                      _playerB3.text = input[3].text;
                                                      _playerB4.text = input[4].text;
                                                      _playerB5.text = input[5].text;
                            }]];
                            [self presentViewController:setTeamB animated:YES completion:nil];
    }]];
    [self presentViewController:setTeamA animated:YES completion:nil];
}

- (IBAction)ChangePeriod:(UIButton *)sender {
    int nextPeriod = periodCounter + 1;
    NSString *message = @"";
    if (nextPeriod >= 4) {
        message = @"finir la partie";
    } else {
        message = [NSString stringWithFormat:@"passer à la %i", nextPeriod];
    }
    UIAlertController* areYouSure = [UIAlertController
                                     alertControllerWithTitle: @"Changer de période"
                                     message: [NSString stringWithFormat:@"Êtes-vous sûr de vouloir %@", message]
                                     preferredStyle:UIAlertControllerStyleAlert];
    [areYouSure addAction:[UIAlertAction
                         actionWithTitle:@"Oui"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             periodCounter ++;
                             _period.text = [NSString stringWithFormat:@"Période : %i", periodCounter];
                             if (nextPeriod + 1 >= 3) {
                                 [sender setTitle:@"fin de partie" forState:UIControlStateNormal];
                             }
                             if (nextPeriod == 4) {
                                 _ChangerPeriodButton.enabled = NO;
                             }

    }]];
    
    [areYouSure addAction:[UIAlertAction
                           actionWithTitle:@"Non"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action) {
                               
    }]];
    
    [self presentViewController:areYouSure animated:YES completion:nil];
    
}

- (void)resetGame {
    _teamA.text = @"ÉquiepA";
    _teamA.text = @"ÉquiepB";
    
    _playerA1.text = @"";
    _playerA2.text = @"";
    _playerA3.text = @"";
    _playerA4.text = @"";
    _playerA5.text = @"";
    
    _playerB1.text = @"";
    _playerB2.text = @"";
    _playerB3.text = @"";
    _playerB4.text = @"";
    _playerB5.text = @"";
}
@end

