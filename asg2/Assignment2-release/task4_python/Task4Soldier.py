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
import random

class Task4Soldier(Soldier): #added
    def __init__(self):
        super(Task4Soldier, self).__init__()
        self._defence = 0
        self._coins = 0
        
    def display_information(self):
        super(Task4Soldier, self).display_information()
        print("Defence :%d."% self._defence)
        print("Coins :%d." % self._coins)
        
    def get_coin(self):
        self._coins += 1
        
    def count_coin(self):
        return self._coins
    
    def buy_elixir(self, price):
        super().add_elixir()
        self._coins -= price

    def buy_shield(self, price):
        if price <= self._coins:
            self._defence += 5
            self._coins -= price
            return True
        else: return False
                
    def lose_health(self):
        self._health -=  (10 - self._defence) if (10 - self._defence)>=0 else 0
        return self._health<=0