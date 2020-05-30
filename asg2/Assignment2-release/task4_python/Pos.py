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

class Pos():
    def __init__(self):
        self._row = None
        self._column = None
    
    def set_pos(self, row, column):
        self._row = row
        self._column = column
    
    def get_row(self):
        return self._row
    
    def get_column(self):
        return self._column
