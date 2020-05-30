/*
 * CSCI3180 Principles of Programming Languages
 *
 * --- Declaration ---
 *
 * I declare that the assignment here submitted is original except for source
 * material explicitly acknowledged. I also acknowledge that I am aware of
 * University policy and regulations on honesty in academic work, and of the
 * disciplinary guidelines and procedures applicable to breaches of such policy
 * and regulations, as contained in the website
 * http://www.cuhk.edu.hk/policy/academichonesty/
 * 
 * Assignment 2
 * Name : Chung Tsz Ting
 * Student ID : 1155110208
 * Email Addr : ttchung8@cse.cuhk.edu.hk
 */

import java.util.Scanner;
public class Task4Monster extends Monster{

  public Task4Monster(int monsterID, int healthCapacity){
    super(monsterID, healthCapacity);
  }

  public boolean loseHealth() {
    super.health -= 10;
    return super.health <= 0;
  }

  public void actionOnSoldier(Task4Soldier soldier) {
    boolean fightEnabled = true;

    while (fightEnabled) {
      System.out.printf("       | Monster%d | Soldier |%n", super.getMonsterID());
      System.out.printf("Health | %8d | %7d |%n%n", super.getHealth(), soldier.getHealth());
      System.out.printf("=> What is the next step? (1 = Attack, 2 = Escape, 3 = Use Elixir.) Input: ");

      Scanner sc = new Scanner(System.in);

      String choice = sc.nextLine();

      if (choice.equalsIgnoreCase("1")) {
        if (super.loseHealth()) {
          System.out.printf("=> You defeated Monster%d.%n%n", super.getMonsterID());
          this.dropItems(soldier);
          fightEnabled = false;
        } else {
          if (soldier.loseHealth()) {
            super.recover(super.getHealthCapacity());
            fightEnabled = false;
          }
        }
      } else if (choice.equalsIgnoreCase("2")) {
        super.recover(super.getHealthCapacity());
        fightEnabled = false;
      } else if (choice.equalsIgnoreCase("3")) {
        if (soldier.getNumElixirs() == 0) {
          System.out.printf("=> You have run out of elixirs.%n%n");
        } else {
          soldier.useElixir();
        }
      } else {
        System.out.printf("=> Illegal choice!%n%n");
      }
    }
  }

  public void fight(Task4Soldier soldier) {
    super.fight((Task4Soldier)soldier);
  }

  public void dropItems(Task4Soldier soldier) {
    super.dropItems((Task4Soldier)soldier);
    soldier.getCoin();
  }
}