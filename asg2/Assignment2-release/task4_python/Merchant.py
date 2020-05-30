"""
CSCI3180 Principles of Programming Languages

--- Declaration ---

I declare that the assignment here submitted is original except for source
material explicitly acknowledged. I also acknowledge that I am aware of
University policy and regulations on honesty in academic work, and of the
disciplinary guidelines and procedures applicable to breaches of such policy
and regulations, as contained in the website
http://www.cuhk.edu.hk/policy/academichonesty/

Assignment 2
Name : Chung Tsz Ting
Student ID : 1155110208
Email Addr : ttchung8@cse.cuhk.edu.hk
"""
from Pos import Pos
from Soldier import Soldier
from Task4Soldier import Task4Soldier

class Merchant(): #added
    def __init__(self):
        self._elixir_price = 1
        self._shield_price = 2
        self._pos = Pos()
        
    def get_pos(self):
        return self._pos
    
    def set_pos(self, row, column):
        self._pos.set_pos(row, column)
        
    def talk(self, text):
        print("Merchant$: " + text, end='')
            
    def action_on_soldier(self, soldier):
        commu_enable = True if soldier.count_coin() > 0 else False
        if not commu_enable: self.talk("You don't have enough coins.\n\n")
        while commu_enable:
            self.talk("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ")
            x = input()
            if x == '1':
                soldier.buy_elixir(self._elixir_price)
                commu_enable = False
            elif x == '2':
                if not soldier.buy_shield(self._shield_price):
                    self.talk("You don't have enough coins.\n\n")
                commu_enable = False
            elif x == '3':
                self.talk('Bye.\n\n')
                commu_enable = False
            else: print('=> Illegal choice!\n')
                
    def display_symbol(self):
        print('$', end = '')