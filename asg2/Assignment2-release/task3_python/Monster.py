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
class Monster():
    def __init__(self, monster_id, health_capacity):
        self._monster_id = monster_id
        self._health_capacity = health_capacity
        self._health = health_capacity
        self._pos = Pos()
        self._drop_item_list = []
        self._hint_list = []
        
    def add_drop_item(self, key):
        self._drop_item_list.append(key)
        
    def add_hint(self, monster_id):
        self._hint_list.append(monster_id)
        
    def get_monster_id(self):
        return self._monster_id
    
    def get_pos(self):
        return self._pos
    
    def set_pos(self, row, column):
        self._pos.set_pos(row, column);
        
    def get_health_capacity(self):
        return self._health_capacity
    
    def get_health(self):
        return self._health
    
    def lose_health(self):
        self._health -= 10
        return self._health<=0
    
    def recover(self, healing_power):
        self._health = healing_power
        
    def talk(self, text):
        print("Monster",self._monster_id,": ",text, sep = '');
        
    def require_key(self, keys):
        return self._monster_id in keys
    
    def display_hints(self):
        text = "Defeat Monster"+ str(self._hint_list) +" first.\n"
        self.talk(text)
    
    def drop_items(self, soldier):
        for item in self._drop_item_list:
            soldier.add_key(item)
        
    def fight(self, soldier):
        fight_enabled = True
        while fight_enabled:
            print("       | Monster%d | Soldier |" % self._monster_id);
            print("Health | %8d | %7d |\n" % (self._health, soldier.get_health()))
            print("=> What is the next step? (1 = Attack, 2 = Escape, 3 = Use Elixir.) Input: ",end='')
            choice = input()
            if choice == '1':
                if self.lose_health():
                    print("=> You defeated Monster", self._monster_id, '\n', sep = '')
                    self.drop_items(soldier)
                    fight_enabled = False
                else:
                    if soldier.lose_health():
                        self.recover(self._health_capacity)
                        fight_enabled = False
                        
            elif choice == '2':
                self.recover(self._health_capacity)
                fight_enabled = False
                
            elif choice == '3':
                if soldier.get_num_elixirs() == 0:
                    print("=> You have run out of elixirs.\n");
                else:  soldier.use_elixir()
                    
            else: print("=> Illegal choice!\n")  
                
    def action_on_soldier(self, soldier):
        if self._health <= 0:
            self.talk("You had defeated me.\n")
        else:
            if self.require_key(soldier.get_keys()):
                self.fight(soldier)
            else: self.display_hints()
                
    def display_symbol(self):
        print('M', end = '')