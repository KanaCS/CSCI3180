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
from Monster import Monster
class Task4Monster(Monster):
    def __init__(self, monster_id, health_capacity):
        super(Task4Monster, self).__init__(monster_id, health_capacity)
    
    def drop_items(self, soldier):
        super(Task4Monster, self).drop_items(soldier)
        soldier.get_coin() #new feature -- soldier get 1 coin
