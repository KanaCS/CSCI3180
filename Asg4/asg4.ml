(* 
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
*)

datatype suit = Clubs | Diamonds | Hearts | Spades;

datatype hand = Nothing | Pair | Two_Pairs | Three_Of_A_Kind | Full_House | Four_Of_A_Kind | Flush | Straight;

type card = (suit * int);
(* left < right *)
fun gt_hand(Four_Of_A_Kind:hand,_:hand) = false
    | gt_hand(_,Four_Of_A_Kind) = true
    | gt_hand(_,Nothing) = false
    | gt_hand(Nothing,_) = true
    | gt_hand(_,Pair) = false
    | gt_hand(Pair,_) = true
    | gt_hand(Full_House,_) = false
    | gt_hand(_,Full_House) = true
    | gt_hand(_,Three_Of_A_Kind) = true
    | gt_hand(_,Two_Pairs) = false
    | gt_hand(_,_) = false;


fun check_flush (cards:card list):bool =
    let
        val first = #1(hd(cards))
        fun check nil = true
        | check (cards:card list as h::t) = 
            if first = #1(h)
            then check t
            else false
    in
        check cards
    end;

fun compare_flush (cardsA: card list, cardsB:card list):string =
    let
        fun compare (nil,nil) = "This is a tie"
        | compare ((h1:card)::t1, (h2:card)::t2) = 
            if #2(h1) > #2(h2)
            then "Hand 1 wins"
            else if #2(h1) < #2(h2)
            then "Hand 2 wins"
            else compare(t1,t2)
    in
        compare (cardsA, cardsB)
    end;

fun check_straight (cards:card list):bool =
    let
        val first =
            if #2(hd(cards))=1
            then 14
            else #2(hd(cards))
        fun check nil = true
        | check (cards as (h:card)::t) = 
        let
            val x = length(cards)
        in
            if (first-5-x) = #2(h)
            then check t
            else false
        end;
    in
        check (tl cards)
    end;

fun compare_straight (cardsA:card list, cardsB:card list):string =
    let
        val A =
            if #2(hd(cardsA))=1
            then 14
            else #2(hd(cardsA))
        val B =
            if #2(hd(cardsB))=1
            then 14
            else #2(hd(cardsB))
    in
        if A > B
        then "Hand 1 wins"
        else if A < B
        then "Hand 2 wins"
        else "This is a tie"
    end;

fun count(cards: card list): (int * int) list=
    let
        val ls = []
        fun check (nil:card list,carda:int,cnt:int):(int * int) list = (carda, cnt)::nil
        | check (h::t,carda,cnt) = 
            if carda = #2(h)
            then check (t,#2(h),cnt+1)
            else (carda, cnt)::check (t,#2(h),1)
    in
        check (tl cards,#2(hd(cards)),1)
    end;



fun sort [] = [] 
| sort (ls:(int * int) list):(int * int) list = 
    let
        fun checksort [] = true  
        | checksort [x] = true 
        | checksort (ls:(int * int) list as x::y::t) : bool = 
            if #2(x) > #2(y) 
            then true andalso checksort(y::t)
            else if #2(x) = #2(y) 
            then if #1(x) >= #1(y)
                then true andalso checksort(y::t)
                else false
            else false
        fun bsort [] = []
        | bsort [x] = [x]
        | bsort (ls:(int * int) list as x::y::t): (int * int) list = 
            if #2(x) < #2(y)
            then (y::bsort(x::t))
            else if #2(x) = #2(y)
            then if #1(x) < #1(y)
                then (y::bsort(x::t))
                else (x::bsort(y::t))
            else (x::bsort(y::t))
    in
        if (checksort ls) 
        then ls
        else sort (bsort ls)
    end;

fun count_patterns(cards: card list) : hand * (int * int) list = 
    let
        val ls =  sort (count cards)
        fun cpatn (cards: (int * int) list as (_,4)::t,_): hand * (int * int) list = (Four_Of_A_Kind, ls)
        | cpatn ((_,3)::t,0) = cpatn(t,3)
        | cpatn ((_,2)::t,0) = cpatn(t,2)
        | cpatn ((_,1)::t,0) =  cpatn(t,1)
        | cpatn ((_,2)::t,3) = (Full_House, ls) 
        | cpatn ((_,1)::t,3) = (Three_Of_A_Kind, ls) 
        | cpatn ((_,2)::t,2) = (Two_Pairs, ls)
        | cpatn ((_,1)::t,2) = (Pair, ls)
        | cpatn (_,_) = (Nothing, ls)     
    in 
        cpatn (ls,0)
    end;

fun compare_count (cardsA:card list, cardsB:card list) : string =
    let
        val lsA = count_patterns(cardsA)
        val typeA = #1(lsA)
        val patnA = #2(lsA)
        val lsB = count_patterns(cardsB)
        val typeB = #1(lsB)
        val patnB = #2(lsB)
        fun compare (nil,nil) = "This is a tie"
        | compare (ls1:(int * int) list as h1::t1, ls2:(int * int) list as h2::t2):string = 
            if #1(h1) > #1(h2)
            then "Hand 1 wins"
            else if #1(h1) < #1(h2)
            then "Hand 2 wins"
            else compare(t1,t2)
        | compare (_,nil) = "Something wrong"
        | compare (nil,_) = "Something wrong"
    in
        if gt_hand(typeA,typeB)
        then "Hand 2 wins"
        else if gt_hand(typeB,typeA)
        then "Hand 1 wins"
        else compare (patnA, patnB)         
    end;


(*******************************************************************
sort (count [(Hearts, 13), (Hearts, 10), (Hearts, 7), (Hearts, 7), (Clubs, 2)]);
count_patterns [(Hearts, 7), (Hearts, 7), (Hearts, 7), (Hearts, 2), (Clubs, 2)];
count_patterns [(Hearts, 13), (Hearts, 13), (Hearts, 13), (Hearts, 13), (Clubs, 2)];
sort ([(13,2),(14,2),(15,1)]);
check_flush [(Hearts, 13), (Hearts, 11), (Hearts, 7), (Hearts, 3), (Clubs, 2)];
check_flush [(Clubs, 13), (Clubs, 11), (Clubs, 7), (Clubs, 3), (Clubs, 2)];
check_flush [(Clubs, 13), (Clubs, 12), (Clubs, 11), (Clubs, 10), (Clubs, 9)];
check_flush [(Clubs, 1),(Clubs, 13), (Clubs, 12), (Clubs, 11), (Clubs, 10)];
compare_flush ([(Hearts, 13), (Hearts, 10), (Hearts, 7), (Hearts, 3), (Hearts, 1)],[(Clubs, 13), (Clubs, 10), (Clubs, 7), (Clubs, 3), (Clubs, 1)]);
compare_straight ([(Hearts, 7), (Hearts, 10), (Hearts, 7), (Hearts, 3), (Hearts, 1)],[(Clubs, 9), (Clubs, 10), (Clubs, 7), (Clubs, 3), (Clubs, 2)]);
compare_count ([(Hearts, 1), (Hearts, 3), (Hearts, 3), (Hearts, 3), (Hearts, 5)],[(Clubs, 10), (Clubs, 9), (Clubs, 7), (Clubs, 3), (Clubs, 3)]);

gt_hand(Pair,Two_Pairs);
gt_hand(Two_Pairs,Pair);
gt_hand(Pair,Three_Of_A_Kind);
gt_hand(Pair,Full_House);
gt_hand(Three_Of_A_Kind,Pair);
gt_hand(Full_House,Pair);
gt_hand(Two_Pairs,Three_Of_A_Kind);
gt_hand(Three_Of_A_Kind,Two_Pairs);
gt_hand(Two_Pairs,Full_House);
gt_hand(Full_House,Two_Pairs);
gt_hand(Full_House,Three_Of_A_Kind);
gt_hand(Three_Of_A_Kind,Full_House);

only prob --> Warning: match nonexhaustive for compare_count and also ?? need test 
*)
