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
- (IBAction)AddGoalButton:(UIButton *)sender;

- (IBAction)ChangeÉquipeGoal:(UITextField *)sender;
- (IBAction)ChangeMarqueurGoal:(UITextField *)sender;
- (IBAction)ChangePasse1Goal:(UITextField *)sender;
- (IBAction)ChangePasse2Goal:(UITextField *)sender;

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
@property (weak, nonatomic) IBOutlet UILabel *butEquipeA;
@property (weak, nonatomic) IBOutlet UILabel *butEquipeB;
@property (weak, nonatomic) IBOutlet UIButton *goalButton;


@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *ÉquipeGoalField;
@property (weak, nonatomic) IBOutlet UITextField *MarqueurGoalField;
@property (weak, nonatomic) IBOutlet UITextField *Passe1GoalField;
@property (weak, nonatomic) IBOutlet UITextField *Passe2GoalField;
@property (weak, nonatomic) IBOutlet UITableView *LogTableView;

@end

@implementation ViewController

int periodCounter = 1;
int indexMarqueur = 0;
int indexPasse1 = 0;
int indexPasse2 = 0;

int goalTeamA = 0;
int goalTeamB = 0;

NSMutableArray<NSString *> *teamAarray;
NSMutableArray<NSString *> *teamBarray;

NSMutableArray<Player *> *teamAPlayerarray;
NSMutableArray<Player *> *teamBPlayerarray;

NSMutableArray<NSString*>* addGoalArray;
NSMutableArray<NSMutableString*>* goalLogArray;

UITextField* currentSelectedTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    teamAarray = [[NSMutableArray alloc] init];
    teamBarray = [[NSMutableArray alloc] init];
    teamAPlayerarray = [[NSMutableArray alloc] init];
    teamBPlayerarray = [[NSMutableArray alloc] init];
    addGoalArray = [[NSMutableArray alloc] init];
    goalLogArray = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)NewGameButton:(UIButton *)sender {
    [self resetGame];
    
    NSString *title = @"Équipe Maison";
    NSString *message = @"Veuillez entrer le nom et numéro des joueur de l'équipe\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
    UIAlertController *setTeamA = [UIAlertController
                                alertControllerWithTitle: title
                                message: message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UITextField *teamNameATextField = [[UITextField alloc] init];;
    NSMutableArray<UITextField *> *numberATextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
    NSMutableArray<UITextField *> *firstNameATextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
    NSMutableArray<UITextField *> *lastNameATextFields= [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
    
    [self addTeam:setTeamA :teamNameATextField :numberATextFields :firstNameATextFields :lastNameATextFields];
    
    [setTeamA addAction:
     [UIAlertAction actionWithTitle:@"OK"
      style:UIAlertActionStyleDefault
      handler:^(UIAlertAction *action) {
          
          NSMutableArray<UILabel *> *playerALabels = [[NSMutableArray<UILabel *> alloc] initWithCapacity:5];
          playerALabels[0] = _playerA1;
          playerALabels[1] = _playerA2;
          playerALabels[2] = _playerA3;
          playerALabels[3] = _playerA4;
          playerALabels[4] = _playerA5;
          
          for (int i = 0 ; i < 5; i++) {
              [teamAarray addObject: [NSString stringWithFormat:@"%@, %@, %@", numberATextFields[i].text, firstNameATextFields[i].text, lastNameATextFields[i].text]];
              Player *player = [[Player alloc] initPlayer: firstNameATextFields[i].text nom:lastNameATextFields[i].text numero:numberATextFields[i].text];
              [teamAPlayerarray addObject:player];
              playerALabels[i].text = [NSString stringWithFormat:@"%@, %@, %@", numberATextFields[i].text, firstNameATextFields[i].text, lastNameATextFields[i].text];
          }
          
          _teamA.text = [NSString stringWithFormat:@"Équipe %@", teamNameATextField.text];
          
          NSString *title = @"Équipe Visiteur";
          NSString *message = @"Veuillez entrer le nom et numéro des joueur de l'équipe\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
          UIAlertController *setTeamB = [UIAlertController
                                         alertControllerWithTitle: title
                                         message: message
                                         preferredStyle:UIAlertControllerStyleAlert];
          
          UITextField *teamNameBTextField = [[UITextField alloc] init];;
          NSMutableArray<UITextField *> *numberBTextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
          NSMutableArray<UITextField *> *firstNameBTextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
          NSMutableArray<UITextField *> *lastNameBTextFields= [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
          
          [self addTeam:setTeamB :teamNameBTextField :numberBTextFields :firstNameBTextFields :lastNameBTextFields];
          
          [setTeamB addAction:
           [UIAlertAction actionWithTitle:@"OK"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction *action) {
                NSMutableArray<UILabel *> *playerBLabels = [[NSMutableArray<UILabel *> alloc] initWithCapacity:5];
                playerBLabels[0] = _playerB1;
                playerBLabels[1] = _playerB2;
                playerBLabels[2] = _playerB3;
                playerBLabels[3] = _playerB4;
                playerBLabels[4] = _playerB5;
                
                for (int i = 0 ; i < 5; i++) {
                    [teamBarray addObject: [NSString stringWithFormat:@"%@, %@, %@", numberBTextFields[i].text, firstNameBTextFields[i].text, lastNameBTextFields[i].text]];
                    playerBLabels[i].text = [NSString stringWithFormat:@"%@, %@, %@", numberBTextFields[i].text, firstNameBTextFields[i].text, lastNameBTextFields[i].text];
                    Player *player = [[Player alloc] initPlayer: firstNameBTextFields[i].text nom:lastNameBTextFields[i].text numero:numberBTextFields[i].text];
                    [teamBPlayerarray addObject:player];
                }
                
                _teamB.text = [NSString stringWithFormat:@"Équipe %@", teamNameBTextField.text];
                
          }]];
          [self presentViewController:setTeamB animated:YES completion:nil];
      }]];
    [self presentViewController:setTeamA animated:YES completion:nil];
}

- (IBAction)ChangePeriod:(UIButton *)sender {
    int nextPeriod = periodCounter + 1;
    int scoreA = 2;
    int scoreB = 1;
    NSString *message = @"";
    if (nextPeriod >= 4) {
        message = @"finir la partie";
    } else {
        message = [NSString stringWithFormat:@"passer à la période %i", nextPeriod];
    }
    UIAlertController *areYouSure = [UIAlertController
                                     alertControllerWithTitle: @"Changer de période"
                                     message: [NSString stringWithFormat:@"Êtes-vous sûr de vouloir %@", message]
                                     preferredStyle:UIAlertControllerStyleAlert];
    [areYouSure addAction:[UIAlertAction
                         actionWithTitle:@"Oui"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             periodCounter ++;
                             if (nextPeriod + 1 >= 4) {
                                 [sender setTitle:@"fin de partie" forState:UIControlStateNormal];
                             }
                             if (nextPeriod == 4) {
                                 _ChangerPeriodButton.enabled = NO;
                                 _ÉquipeGoalField.enabled = NO;
                                 _MarqueurGoalField.enabled = NO;
                                 _Passe1GoalField.enabled = NO;
                                 _Passe2GoalField.enabled = NO;
                                 _goalButton.enabled = NO;
                                 NSString *endGameMessage = @"";
                                 if (scoreA < scoreB) {
                                     endGameMessage = [NSString stringWithFormat:@"%@ a gagné!", _teamB.text];
                                 } else if (scoreA > scoreB) {
                                     endGameMessage = [NSString stringWithFormat:@"%@ a gagné!", _teamA.text];
                                 } else {
                                     endGameMessage = @"C'est une partie null!";
                                 }
                                 UIAlertController *endGame = [UIAlertController
                                                               alertControllerWithTitle: @"Fin de partie"
                                                               message: endGameMessage
                                                               preferredStyle:UIAlertControllerStyleAlert];
                                 [endGame addAction:[UIAlertAction
                                                      actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {[self presentEtoile];}]];
                                 [self presentViewController:endGame animated:YES completion:nil];
                             }
                             else
                                 _period.text = [NSString stringWithFormat:@"Période : %i", periodCounter];
                            
    }]];
    
    [areYouSure addAction:[UIAlertAction
                           actionWithTitle:@"Non"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action) {
                               
    }]];
    
    [self presentViewController:areYouSure animated:YES completion:nil];
    
}

- (void)resetGame
{
    teamAarray = [[NSMutableArray alloc] init];
    teamBarray = [[NSMutableArray alloc] init];
    teamAPlayerarray = [[NSMutableArray alloc] init];
    teamBPlayerarray = [[NSMutableArray alloc] init];
    addGoalArray = [[NSMutableArray alloc] init];
    goalLogArray = [[NSMutableArray alloc] init];

    [_LogTableView reloadData];
    
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
    
    _ÉquipeGoalField.text = @"";
    _MarqueurGoalField.text = @"";
    _Passe1GoalField.text = @"";
    _Passe2GoalField.text = @"";
    
    _butEquipeA.text = @"0";
    _butEquipeB.text = @"0";
    
    _period.text = @"Période : 1";
    periodCounter = 1;
    [_ChangerPeriodButton setTitle:@"Changer de période" forState:UIControlStateNormal];
    
    _ÉquipeGoalField.enabled = YES;
    _MarqueurGoalField.enabled = YES;
    _Passe1GoalField.enabled = YES;
    _Passe2GoalField.enabled = YES;
    _ChangerPeriodButton.enabled = YES;
    _goalButton.enabled = YES;
    
    [self hidePickerView];
}

- (void) addTeam:(UIAlertController *) controller
                :(UITextField *) teamNameTextField
                :(NSMutableArray<UITextField *> *) numberTextFields
                :(NSMutableArray<UITextField *> *) firstNameTextFields
                :(NSMutableArray<UITextField *> *) lastNameTextFields {
    controller.modalInPopover = true;
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, 300, 300)];
    
    UILabel *teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 200, 25)];
    teamLabel.text = @"Équipe";
    
    teamNameTextField.frame = CGRectMake(6, 25, 256, 25);
    teamNameTextField.placeholder = @"Nom de l'équipe";
    teamNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    teamNameTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    [inputView addSubview:teamLabel];
    [inputView addSubview:teamNameTextField];
    
    for (int i = 0; i < 5; i++) {
        UILabel *playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 50+i*50, 200, 25)];
        playerLabel.text = [NSString stringWithFormat:@"Joueur %i", (i+1)];
        
        UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(6, 75+i*50, 50, 25)];
        numberTextField.placeholder = @"#";
        numberTextField.borderStyle = UITextBorderStyleRoundedRect;
        numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
        numberTextFields[i] = numberTextField;
        
        UITextField *firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(62, 75+i*50, 97, 25)];
        firstNameTextField.placeholder = @"Prénom";
        firstNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        firstNameTextField.keyboardType = UIKeyboardTypeDecimalPad;
        firstNameTextFields[i] = firstNameTextField;
        
        UITextField *lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(165, 75+i*50, 97, 25)];
        lastNameTextField.placeholder = @"Nom";
        lastNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        lastNameTextField.keyboardType = UIKeyboardTypeDecimalPad;
        lastNameTextFields[i] = lastNameTextField;
        
        [inputView addSubview:playerLabel];
        [inputView addSubview:numberTextFields[i]];
        [inputView addSubview:firstNameTextFields[i]];
        [inputView addSubview:lastNameTextFields[i]];
    }
    
    [controller.view addSubview:inputView];
}

- (void)showPickerView{
    _picker.delegate = self;
    _picker.dataSource = self;
    _pickerView.alpha = 1;
    currentSelectedTextField.userInteractionEnabled = NO;
    [currentSelectedTextField resignFirstResponder];
    [_picker reloadAllComponents];
}
- (void)hidePickerView{
    _pickerView.alpha = 0;
    currentSelectedTextField.userInteractionEnabled = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;  // Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return [addGoalArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return addGoalArray[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    currentSelectedTextField.text = addGoalArray[row];
    if(currentSelectedTextField.tag == 1)
        indexMarqueur = row;
    else if(currentSelectedTextField.tag == 2)
        indexPasse1 = row;
    else if(currentSelectedTextField.tag == 3)
        indexPasse2 = row;
    
    [self hidePickerView];
    
}

- (IBAction)ChangeÉquipeGoal:(UITextField *)sender {
    currentSelectedTextField = sender;
    addGoalArray = [[NSMutableArray alloc] init];
    [addGoalArray addObject:_teamA.text];
    [addGoalArray addObject:_teamB.text];
    [self showPickerView];
 }
 
- (IBAction)ChangeMarqueurGoal:(UITextField *)sender {
     currentSelectedTextField = sender;
     if([_ÉquipeGoalField.text isEqualToString: _teamA.text])
     {
         addGoalArray = teamAarray;
     }
     else
     {
         addGoalArray = teamBarray;
     }
     [self showPickerView];
}
 
- (IBAction)ChangePasse1Goal:(UITextField *)sender {
     currentSelectedTextField = sender;
     if([_ÉquipeGoalField.text isEqualToString: _teamA.text])
     {
         addGoalArray = teamAarray;
     }
     else
     {
         addGoalArray = teamBarray;
     }
     [self showPickerView];
}
 
- (IBAction)ChangePasse2Goal:(UITextField *)sender {
     currentSelectedTextField = sender;
     if([_ÉquipeGoalField.text isEqualToString: _teamA.text])
     {
         addGoalArray = teamAarray;
     }
     else
     {
         addGoalArray = teamBarray;
     }
     [self showPickerView];
}


- (IBAction)AddGoalButton:(UIButton *)sender {
    
    if([_ÉquipeGoalField.text length] != 0 && [_MarqueurGoalField.text length] != 0)
    {
        NSMutableArray<Player *>* goalTeamArray = [[NSMutableArray alloc] init];
        if([_ÉquipeGoalField.text isEqualToString: _teamA.text])
        {
            goalTeamArray = teamAPlayerarray;
            goalTeamA ++;
            _butEquipeA.text = [NSString stringWithFormat:@"%i", goalTeamA];
        }
        else
        {
            goalTeamArray = teamBPlayerarray;
            goalTeamB ++;
            _butEquipeB.text = [NSString stringWithFormat:@"%i", goalTeamB];

        }
        
        
        NSMutableString *goalLog = [NSMutableString stringWithString:@"Période : "];
        
        NSString* periode = [NSString stringWithFormat:@"%i", periodCounter];
        [goalLog appendString:periode];
        NSString* team = _ÉquipeGoalField.text;
        [goalLog appendString: @", "];
        [goalLog appendString: team];
        [goalLog appendString: @", Marqueur :"];
        NSString* scorer = goalTeamArray[indexMarqueur].nom;
        goalTeamArray[indexMarqueur].but += 1;
        goalTeamArray[indexMarqueur].score += 2;
        [goalLog appendString:scorer];
        [goalLog appendString: @", Passe 1 :"];
        NSString* assist1 = goalTeamArray[indexPasse1].nom;
        goalTeamArray[indexPasse1].passe += 1;
        goalTeamArray[indexPasse1].score += 1;
        [goalLog appendString:assist1];
        [goalLog appendString: @", Passe 2 :"];
        NSString* assist2 = goalTeamArray[indexPasse2].nom;
        goalTeamArray[indexPasse2].passe += 1;
        goalTeamArray[indexPasse2].score += 1;
        [goalLog appendString:assist2];
        [goalLogArray addObject:goalLog];
        
        _ÉquipeGoalField.text = @"";
        _MarqueurGoalField.text = @"";
        _Passe1GoalField.text = @"";
        _Passe2GoalField.text = @"";
        
        [_LogTableView reloadData];
    }
    else
    {
        UIAlertController *erreurAlert = [UIAlertController
                                      alertControllerWithTitle: @"Erreur"
                                      message: @"Les champs Équipe et marqueur ne doivent pas être vide!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        [erreurAlert addAction:[UIAlertAction
                            actionWithTitle:@"OK"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction *action) {}]];
        [self presentViewController:erreurAlert animated:YES completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return goalLogArray.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cellIdentifier";
    
    CustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

    if(cell == nil) {
        cell = [[CustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        
    }
    
    cell.textLabel.text = [goalLogArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)presentEtoile{
    NSArray *newPlayerArray=[teamAPlayerarray arrayByAddingObjectsFromArray:teamBPlayerarray];
    
    NSMutableArray<Player *>* etoilePlayerArray = [[NSMutableArray alloc] init];
    
    for(int i =0; i< [newPlayerArray count]; i++)
    {
        int indexPos = -1;
        Player* currentPlayer = (Player*)newPlayerArray[i];
        int score = currentPlayer.score;
        
        if([etoilePlayerArray count] != 0)
        {
            for(int j =0; j< [etoilePlayerArray count]; j++)
            {
                if(score >= etoilePlayerArray[j].score)
                    indexPos = j;
            }
            if(indexPos != -1)
            {
                if([etoilePlayerArray count] == 3)
                {
                    [etoilePlayerArray removeObjectAtIndex:0];
                }
                [etoilePlayerArray insertObject:currentPlayer atIndex:indexPos];
            }
            else if([etoilePlayerArray count] != 3)
            {
                [etoilePlayerArray insertObject:currentPlayer atIndex:0];
            }
        }
        else
        {
            [etoilePlayerArray addObject:currentPlayer];
        }
    }
    
    Player *player = etoilePlayerArray[2];
    
    NSMutableString *etoileMessage = [NSMutableString stringWithString:@"La première étoile revient à "];
    [etoileMessage appendString: player.prenom];
    [etoileMessage appendString: @" "];
    [etoileMessage appendString: player.nom];
    [etoileMessage appendString: @" avec "];
    NSString *but = [NSString stringWithFormat:@"%i", player.but];
    [etoileMessage appendString: but];
    [etoileMessage appendString: @" buts et "];
    NSString *passe = [NSString stringWithFormat:@"%i", player.passe];
    [etoileMessage appendString: passe];
    [etoileMessage appendString: @" passes \n"];
    
    player = etoilePlayerArray[1];
    [etoileMessage appendString: @"La deuxième étoile revient à "];
    [etoileMessage appendString: player.prenom];
    [etoileMessage appendString: @" "];
    [etoileMessage appendString: player.nom];
    [etoileMessage appendString: @" avec "];
    but = [NSString stringWithFormat:@"%i", player.but];
    [etoileMessage appendString: but];
    [etoileMessage appendString: @" buts et "];
    passe = [NSString stringWithFormat:@"%i", player.passe];
    [etoileMessage appendString: passe];
    [etoileMessage appendString: @" passes \n"];
    
    player = etoilePlayerArray[0];
    [etoileMessage appendString: @"La troisième étoile revient à "];
    [etoileMessage appendString: player.prenom];
    [etoileMessage appendString: @" "];
    [etoileMessage appendString: player.nom];
    [etoileMessage appendString: @" avec "];
    but = [NSString stringWithFormat:@"%i", player.but];
    [etoileMessage appendString: but];
    [etoileMessage appendString: @" buts et "];
    passe = [NSString stringWithFormat:@"%i", player.passe];
    [etoileMessage appendString: passe];
    [etoileMessage appendString: @" passes "];
    
    UIAlertController *etoile3Alert = [UIAlertController
                                       alertControllerWithTitle: @"Les étoiles du match"
                                       message: etoileMessage
                                       preferredStyle:UIAlertControllerStyleAlert];
    [etoile3Alert addAction:[UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {}]];
    [self presentViewController:etoile3Alert animated:YES completion:nil];
}

@end

