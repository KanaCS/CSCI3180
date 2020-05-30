import random

random.seed(0) # don't touch!

# you are not allowed to modify Player class!
class Player:
    due = 200
    income = 0
    tax_rate = 0.2
    handling_fee_rate = 0
    prison_rounds = 2

    def __init__(self, name):
        self.name = name
        self.money = 100000
        self.position = 0
        self.num_rounds_in_jail = 0

    def updateAsset(self):
        self.money += Player.income

    def payDue(self):
        self.money += Player.income * (1 - Player.tax_rate)
        self.money -= Player.due * (1 + Player.handling_fee_rate)

    def printAsset(self):
        print("Player %s's money: %d" % (self.name, self.money))

    def putToJail(self):
        self.num_rounds_in_jail = Player.prison_rounds

    def move(self, step):
        if self.num_rounds_in_jail > 0:
            self.num_rounds_in_jail -= 1
        else:
            self.position = (self.position + step) % 36



class Bank:
    def __init__(self):
        pass

    def print(self):
        print("Bank ", end='')

    def stepOn(self):

        Player.income = 2000
        Player.tax_rate = 0
        Player.due = 0
        Player.handling_fee_rate = 0
        cur_player.payDue()
        print("You received $2000 from the Bank!\n")
        return cur_player #???

class Jail:
    def __init__(self):
        pass

    def print(self):
        print("Jail ", end='')

    def stepOn(self):

        print ("Pay $1000 to reduce the prison round to 1? [y/n]");
        while(True):
            x = input()
            if (x=='y'):
                if(cur_player.money >=1000):
                    cur_player.prison_rounds = 1
                    cur_player.putToJail();
                    break;
                else:
                    print ("You do not have enough money to reduce the prison round!")
                    cur_player.prison_rounds = 2
                    cur_player.putToJail();
                    break;
            elif (x == 'n'):
                cur_player.prison_rounds = 2
                cur_player.putToJail();
                break;
            else:
                print ("Please enter [y] or [n].")


class Land:
    land_price = 1000
    upgrade_fee = [1000, 2000, 5000]
    toll = [500, 1000, 1500, 3000]
    tax_rate = [0.1, 0.15, 0.2, 0.25]

    def __init__(self):
        self.owner = None
        self.level = 0

    def print(self):
        if self.owner is None:
            print("Land ", end='')
        else:
            print("%s:Lv%d" % (self.owner.name, self.level), end="")
    
    def buyLand(self):
        if(cur_player.money<1100):
            print("You do not have enough money to buy the land!")
            return 0
        self.owner = cur_player
        Player.income = 0
        Player.tax_rate = 0
        Player.due = 1000
        Player.handling_fee_rate = 0.1
        cur_player.payDue()
    
    def upgradeLand(self):
        mul_idx = self.level+1 if self.level<2 else 5
        if(cur_player.money < (1000*mul_idx)*1.1):
            print ("You do not have enough money to upgrade the land!")
            return 0
        Player.income = 0
        Player.tax_rate = 0
        Player.due = 1000*mul_idx
        Player.handling_fee_rate = 0.1
        cur_player.payDue()
        self.level += 1
    
    def chargeToll(self):
        
        mul_idx = self.level+1 if self.level<3 else 6
        pay = cur_player.money if (cur_player.money <= (500*mul_idx)) else (500*mul_idx)

        Player.income = 0
        Player.tax_rate = 0
        Player.due = pay
        Player.handling_fee_rate = 0.1
        cur_player.payDue()

        self.owner.income = pay
        self.owner.tax_rate = 0.1 + 0.05*self.level
        self.owner.due = 0
        self.owner.handling_fee_rate = 0
        self.owner.payDue()

    def stepOn(self):

        if(self.owner==None):
            print ("Pay $1000 to buy the land? [y/n]")
            while(True):
                x = input()
                if (x=='y'):
                    self.buyLand()
                    break
                elif (x == 'n'):
                    break
                else:
                    print ("Please enter [y] or [n].")
        elif(self.owner.name==cur_player.name):
            if(self.level<3):
                mul_idx = self.level+1 if self.level<2 else 5
                pay = 1000*mul_idx
                print ("Pay",pay,"to upgrade the land? [y/n]")
                while(True):
                    x = input()
                    if (x=='y'):
                        if (self.level<3):
                            self.upgradeLand()
                        break
                    elif (x == 'n'):
                        break
                    else:
                        print ("Please enter [y] or [n].")
        else:
            mul_idx = self.level+1 if self.level<3 else 6
            pay = 500*mul_idx
            print("You need to pay player",self.owner.name,pay)
            self.chargeToll()

        return cur_player



players = [Player("A"), Player("B")]
cur_player = players[0]
num_players = len(players)
cur_player_idx = 0
cur_player = players[cur_player_idx]
num_dices = 1
cur_round = 0

game_board = [
    Bank(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Jail(),
    Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(),
    Jail(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Jail(),
    Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land()
]
game_board_size = len(game_board)


def printCellPrefix(position):
    occupying = []
    for player in players:
        if player.position == position and player.money > 0:
            occupying.append(player.name)
    print(" " * (num_players - len(occupying)) + "".join(occupying), end='')
    if len(occupying) > 0:
        print("|", end='')
    else:
        print(" ", end='')


def printGameBoard():
    print("-" * (10 * (num_players + 6)))
    for i in range(10):
        printCellPrefix(i)
        game_board[i].print()
    print("\n")
    for i in range(8):
        printCellPrefix(game_board_size - i - 1)
        game_board[-i - 1].print()
        print(" " * (8 * (num_players + 6)), end="")
        printCellPrefix(i + 10)
        game_board[i + 10].print()
        print("\n")
    for i in range(10):
        printCellPrefix(27 - i)
        game_board[27 - i].print()
    print("")
    print("-" * (10 * (num_players + 6)))


def terminationCheck():
    for i in range(0,2):
        if(players[i].money<=0):
            print("Game over! winner:", players[i^1].name)
            return False
    return True


def throwDice():
    step = 0
    for i in range(num_dices):
        step += random.randint(1, 6)
    return step


def main():
    global cur_player
    global num_dices
    global cur_round
    global cur_player_idx

    while terminationCheck():
        cur_round += 1
        cur_player = players[cur_player_idx]
        
        if (cur_player.num_rounds_in_jail<=0):
            printGameBoard()
            for player in players:
                player.printAsset()

        Player.income = 0
        Player.tax_rate = 0
        Player.due = 200
        Player.handling_fee_rate = 0
        cur_player.payDue()

        if(cur_player.num_rounds_in_jail>0):
            cur_player.move(0)
            cur_player_idx = cur_player_idx^1
            continue

        print("Player {}'s turn.".format(cur_player.name))
        print("Pay $500 to throw two dice? [y/n]")
        while(True):
            x = input()
            if (x=='y'):
                if(cur_player.money<500*1.05):
                    print("You do not have enough money to throw two dice!")
                    num_dices = 1
                    dice = throwDice()
                else:
                    num_dices = 2
                    dice = throwDice()
                    Player.income = 0
                    Player.tax_rate = 0
                    Player.due = 500
                    Player.handling_fee_rate = 0.05
                    cur_player.payDue()
                break
            elif (x == 'n'):
                num_dices = 1
                dice = throwDice()
                break
            else:
                print ("Please enter [y] or [n].")
        print("Points of dice:", dice)
        cur_player.move(dice)

        game_board[cur_player.position].stepOn()

        cur_player_idx = cur_player_idx^1
    # ...


if __name__ == '__main__':
    main()
