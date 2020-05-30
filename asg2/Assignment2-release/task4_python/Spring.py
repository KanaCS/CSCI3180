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
class Spring():
    def __init__(self):
        self._numChance = 1
        self._healingPower = 100
        self._pos = Pos()

    def set_pos(self, row, column):
        self._pos._row = row
        self._pos._column = column
        
    def get_pos(self):
        return self._pos
    
    def talk(self):
        print("Spring@: You have %d chance to recover 100 health.\n" % self._numChance)
    
    def action_on_soldier(self, soldier):
        self.talk()
        if self._numChance == 1:
            soldier.recover(self._healingPower)
            self._numChance -= 1
    
    def display_symbol(self):
        print("@", end = '')