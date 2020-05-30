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
import random
class Soldier():
    def __init__(self):
        self._health = 100
        self._num_elixirs = 2
        self._pos = Pos()
        self._keys = []
        
    def get_health(self):
        return self._health
    
    def lose_health(self):
        self._health -= 10
        return self._health<=0
    
    def recover(self, healing_power):
        total_health = healing_power + self._health
        self._health = 100 if total_health >= 100 else total_health
        
    def get_pos(self):
        return self._pos
    
    def set_pos(self, row, column):
        self._pos.set_pos(row, column)
        
    def move(self, row, column):
        self._pos.set_pos(row, column)

    def get_keys(self):
        return self._keys

    def add_key(self, key):
        self._keys.append(key)

    def get_num_elixirs(self):
        return self._num_elixirs

    def add_elixir(self):
        self._num_elixirs += 1

    def use_elixir(self):
        self.recover(random.randint(15, 21))
        self._num_elixirs -= 1

    def display_information(self):
        print("Health:", self._health);
        print("Position (row, column): (",self._pos.get_row()," ", self._pos.get_column(),")", sep = '')
        print("Keys:", self._keys);
        print("Elixirs: %d" % self._num_elixirs)


    def display_symbol(self):
        print("S", end = '')