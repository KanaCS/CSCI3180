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

import java.util.HashSet;
import java.util.Random;

public class Task4Soldier extends Soldier{
  private int defence;
  private int coins;

  public Task4Soldier(){
    this.defence = 0;
    this.coins = 0;
  }

  public void displayInformation() {
    super.displayInformation();
    System.out.printf("Defence :%d.%n", this.defence);
    System.out.printf("Coins :%d.%n" , this.coins);
  }

  public void getCoin() {
    this.coins += 1;
  }

  public int countCoin() {
    return this.coins;
  }

  public void buyElixir(int price){
    super.addElixir();
    this.coins -= price;
  }

  public boolean buyShield(int price){
    if(price <= this.coins){
      this.defence += 5;
      this.coins -= price;
      return true;
    }
    else{
      return false;
    }
  }

  public boolean loseHealth() {
    if ((10 - this.defence)>=0){
      this.health -=  (10 - this.defence);
    }
    return this.health<=0;
  }

}