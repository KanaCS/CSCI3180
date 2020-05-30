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
from Cell import Cell
from Soldier import Soldier
from Monster import Monster
from Spring import Spring
class Map():
    def __init__(self):
        self._cells = []
        for i in range(7):
            self._cells.append([])
            for j in range(7):
                self._cells[i].append(Cell())
    
    def add_object(self, object):
        if type(object) == list:
            for sub_object in object:
                pos = sub_object.get_pos()
                self._cells[pos.get_row() - 1][pos.get_column() - 1].set_occupied_object(sub_object)
        else:
            pos = object.get_pos()
            self._cells[pos.get_row() - 1][pos.get_column() - 1].set_occupied_object(object)

    def display_map(self):
        print("   | 1 | 2 | 3 | 4 | 5 | 6 | 7 |")
        print("--------------------------------")
        for i in range(7):
            print(" %d |" % (i + 1), end='');
            for j in range(7):
                occupied_object = self._cells[i][j].get_occupied_object()
                if occupied_object != None:
                    print(" ", end='')
                    occupied_object.display_symbol()
                    print(" |", end='')
                else: print("   |", end='')
            print('\n--------------------------------')
    
                
    def get_occupied_object(self, row, column):
        return self._cells[row - 1][column - 1].get_occupied_object()
    
    def check_move(self, row, column):
        return (row >= 1 and row <= 7) and (column >= 1 and column <= 7)
                    
    def update(self, soldier, old_row, old_column, new_row, new_column):
        self._cells[old_row - 1][old_column - 1].set_occupied_object(None);
        self._cells[new_row - 1][new_column - 1].set_occupied_object(soldier);
        