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
public class Merchant {
  private int elixirPrice;
  private int shieldPrice;
  private Pos pos;

  public Merchant() {
    this.elixirPrice = 1;
    this.shieldPrice = 2;
    this.pos = new Pos();
  }

  public void actionOnSoldier(Task4Soldier soldier) {
    boolean commuEnable;
    if (soldier.countCoin() > 0){
      commuEnable = true;
    }
    else{
      commuEnable = false;
      this.talk("You don't have enough coins.%n%n");
    }

    while (commuEnable){
      this.talk("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ");
      Scanner sc = new Scanner(System.in);
      String choice = sc.nextLine();

      if (choice.equalsIgnoreCase("1")) {
        soldier.buyElixir(this.elixirPrice);
        commuEnable = false;
      }
      else if (choice.equalsIgnoreCase("2")){
        if (!soldier.buyShield(this.shieldPrice)){
          this.talk("You don't have enough coins.%n%n");
        }
        commuEnable = false;
      }
      else if (choice.equalsIgnoreCase("3")){
        this.talk("Bye.%n%n");
        commuEnable = false;
      }
      else{
        System.out.printf("=> Illegal choice!%n");
      }
    }
  }

  public void talk(String text) {
    System.out.printf("Merchant$: " + text);
  }

  public Pos getPos() {
    return this.pos;
  }

  public void setPos(int row, int column) {
    this.pos.setPos(row, column);
  }

  public void displaySymbol(){
    System.out.printf("$");
  }

}