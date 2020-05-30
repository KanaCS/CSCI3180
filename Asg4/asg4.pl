%
% CSCI3180 Principles of Programming Languages
%
% --- Declaration ---
%
% I declare that the assignment here submitted is original except for source
% material explicitly acknowledged. I also acknowledge that I am aware of
% University policy and regulations on honesty in academic work, and of the
% disciplinary guidelines and procedures applicable to breaches of such policy
% and regulations, as contained in the website
% http://www.cuhk.edu.hk/policy/academichonesty/
%
% Assignment 4
% Name : Chung Tsz Ting
% Student ID : 1155110208
% Email Addr : ttchung8@cse.cuhk.edu.hk
%

% 1a. Define element last(X, L) which is true if the last element in list L is X.
element_last(X,L):-append(_,[X],L).

% 1b. Define element n(X, L, N) which is true if the N-th element in list L is X. 
element_n(X,[_|L],s(N)):-element_n(X,L,N).
element_n(X,[X],s(0)).
element_n(X,[X|_],s(0)).

% 1c. Define remove n(X, L1, N, L2) which is true if the resulting list L2 is obtained from
% L1 by removing the N-th element, and X is the removed element.
remove_n(_,[],0,[]).
remove_n(X,[X|L1],s(0),L2):-remove_n(X,L1,0,L2).
remove_n(X,[L|L1],s(N),[L|L2]):-remove_n(X,L1,N,L2).
remove_n(X,[L|L1],0,[L|L2]):-remove_n(X,L1,0,L2).


% 1d. Based on (c), give a query to find which list will become [c,b,d,e] after removing its
% second element “a”.
% ans: remove_n(a,X,s(s(0)),[c,b,d,e]).

% 1e. Define insert n(X, L1, N, L2) which is true if the resulting list L2 is obtained by
% inserting X to the position before the N-th element of list L1.
insert_n(_,[],0,[]).
insert_n(X,L1,s(0),[X|L2]):-insert_n(X,L1,0,L2).
insert_n(X,[L|L1],s(N),[L|L2]):-insert_n(X,L1,N,L2).
insert_n(X,[L|L1],0,[L|L2]):-insert_n(X,L1,0,L2).

% 1f. Define repeat three(L1, L2) which is true if the resulting list L2 has each element in
% list L1 repeated three times. 
repeat_three([],[]).
repeat_three([Ele|L1],[Ele,Ele,Ele|L2]):-repeat_three(L1,L2).

% 1g. Based on (f), give a query to find which list will become [i,i,i,m,m,m,n,n,n] after
% repeating each element of it for three times. 
% ans:repeat_three(X, [i,i,i,m,m,m,n,n,n]).

% 2a. Represent the multi-way tree in Figure 1 as a Prolog term, with order of the sub-trees
% from left to right. (Hint: represent forest as a list of multi-way tree(s)).
% ans: mt(a,[mt(b,[mt(e,[]),mt(f,[])]),mt(c,[]),mt(d,[mt(g,[])])]).

% 2b. Define the predicate is tree(Term) which is true if Term represents a multi-way tree.
is_tree(mt(_,[Sub|Rest])):-is_tree(Sub),trees(Rest).
is_tree(mt(_,[])).
trees([Sub|Rest]):-is_tree(Sub),trees(Rest).
trees([]).

% 2c. Define the predicate num node(Tree, N) which is true if N is the number of nodes of
% the given multi-way tree Tree.
sum(0,X,X).
sum(s(X),Y,s(Z)) :- sum(X,Y,Z).
num_node(mt(_,[Sub|Rest]),s(N)):-num_node(Sub,Na),treesn(Rest,Nb),sum(Na,Nb,N).
num_node(mt(_,[]),s(0)).
treesn([Sub|Rest],N):-num_node(Sub,Na),treesn(Rest,Nb),sum(Na,Nb,N).
treesn([],0).

% 2d. Define sum length(Tree, L) which is true if L is the sum of lengths of all internal
% paths in Tree. The length of an internal path from the root node r to an internal node
% n is the distance from r to n. For example, the sum of lengths of all internal paths in
% the multi-way tree in Figure 1 is: 1 (b) + 1 (c) + 1 (d) + 2 (e) + 2 (f) + 2 (g) = 9
% (i.e., s(s(s(s(s(s(s(s(s(0))))))))).
sum_length(T,L):-num_noden(0,T,L).
num_noden(Dep,mt(_,[Sub|Rest]),S):-num_noden(s(Dep),Sub,Na),treesnn(s(Dep),Rest,Nb),sum(Na,Nb,N),sum(N,s(Dep),S).
num_noden(_,mt(_,[]),0).
treesnn(Dep,[Sub|Rest],S):-num_noden(Dep,Sub,Na),treesnn(Dep,Rest,Nb),sum(Na,Nb,N),sum(N,Dep,S).
treesnn(_,[],0).



    
    
    
    
    
    

