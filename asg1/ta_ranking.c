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
 * Assignment 1
 * Name : Chung Tsz Ting
 * Student ID : 1155110208
 * Email Addr : ttchung8@cse.cuhk.edu.hk
 */

#include<stdio.h>
#include <stdlib.h>
#include<string.h>

char list[9][16];
char top3_n[3][11];
float top3_s[3];

 //for debug
void printtop3(){
    int i;
    printf("\n------------------\n");
    for(i=0;i<=2;i++){
        printf("name[%d]: %s   ",i,top3_n[i]);
        printf("score[%d]: %f\n",i,top3_s[i]);
    }
    printf("------------------\n\n");
}


void calc_top3(char name[],float score){
    int place=0,i;
    char tmp_name[11],tmp_name2[11];
    float tmp_score=0, tmp_score2=0;
    for(i=0;i<=2;i++){
        if(place==1){//after replacement is done, move next to next.next
            strcpy(tmp_name2,top3_n[i]);
            tmp_score2=top3_s[i];
            strcpy(top3_n[i],tmp_name);
            top3_s[i]=tmp_score;
            strcpy(tmp_name,tmp_name2);
            tmp_score=tmp_score2;
        }
        else if(score>top3_s[i]){//see whether need to replace to the existing TA
            strcpy(tmp_name,top3_n[i]); //remember the original (move to next later)
            tmp_score=top3_s[i];
            strcpy(top3_n[i],name); //replacing
            top3_s[i]=score;
            place=1;
        }
    }
}

int compute(){
    //read file and error checking
    FILE *fp1=fopen("candidates.txt","r");
    if(fp1==NULL)
        return -1;
    //initialize
    char *ter,buff[20],name[11];
    int i,j,k,complu=0;
    double tmp_score=0;

    i=0;
    //read the whole file and match with the targeted course
    //1 iteration 1 line of input
    while(i==0 || ter!=NULL){
        int zeroscore=0;
        tmp_score=0,complu=0;

        ter=fgets(name, 12, fp1);//sid
        name[10]='\0';
        
        for(j=0;j<8;j++){ //skills score calc
            ter=fgets(buff, 16, fp1);

            for(k=1;k<4;k++){//complu skills
                if(strcmp(buff,list[k])==0)
                    complu++;
            }
            for(k=4;k<=9;k++){//optional skills
                if(strcmp(buff,list[k])==0)
                    tmp_score++;
            }  
        }
        if(complu==3){
            zeroscore=0;
            tmp_score+=1;
        }
        else{
            zeroscore=1;
            tmp_score=0;
        }
        //printf("tmpscore of %s = %f\n", name,tmp_score);
        for(j=3;j>0;j--){ //preference score calc
            ter=fgets(buff, 6, fp1);//preference 
            buff[4]='\0';
            if(strcmp(list[0],buff)==0 && zeroscore==0)
                tmp_score=tmp_score+0.5*j;
        }
        //printf("final_score of %s = %f\n", name,tmp_score);
        ter=fgets(buff, 3, fp1);
        calc_top3(name,tmp_score);
        i++;
    }
    fclose(fp1);
    return 0;
}

int main(void){
    FILE *fp=fopen("instructors.txt","r"),*fp1=fopen("candidates.txt","r");;
    char buff[20],*ter;
    int i=0,j=0,k=0,score;

    if(fp==NULL || fp1==NULL){
        printf("non-existing file!\n");
        return 0;
    }
    fclose(fp1);
    FILE *wp=fopen("output.txt","w");
    //each iteration one course
    while(i==0 || ter!=NULL){
        ter=fgets(list[0], 6, fp); //list[0]=course
        list[0][4]='\0';
        if(ter==NULL) break;

        for(j=1;j<9;j++){ //list[1:8]  =  3 complu skills and 5 optional skills
            ter=fgets(list[j], 16, fp);
        }
        //initialize top3
        for(k=0;k<3;k++){
            for(j=0;j<10;j++){
                top3_n[k][j]='0';
            }
            top3_n[k][10]='\0';
        }
        top3_s[0]=0;
        top3_s[1]=0;
        top3_s[2]=0;

        score=compute();//compute by matching with candidate.txt
        
        if(score==-1 && i==0) printf("non-existing file!\n");
        //printf("\n<<< %s >>>",list[0]); //printscreen debug
        //printtop3();

        //file out
        fprintf(wp, "%s %s %s %s \n", list[0],top3_n[0],top3_n[1],top3_n[2]); //write to output.txt

        ter=fgets(buff, 3, fp);
        i++;
    }

    fclose(fp);
    fclose(wp);
    return 0;
}