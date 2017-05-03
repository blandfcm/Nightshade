#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *userIPs[20];
char *userIDs[20];
int count = 0;

void printUsers()
{
    int i;
    for(i = 0; i < count; i++)
    {
        printf("user: %s has IP address: %s\n", userIDs[i], userIPs[i]);
    }
}

void freeUsers()
{
    int i;
    for(i = 0; i < count; i++)
    {
        free(userIPs[i]); 
        free(userIDs[i]); 
    }

} void getUsersData()
{
    char buf[1024];
    char name[1024]; 
    int i;
    for(i = 0; i < count; i++)
    {
        strncpy(name, userIDs[i], 30);
        strcat(name, ".txt");
        snprintf(buf, sizeof(buf), "grep '%s' /var/log/dnsmasq.log > '%s'", userIPs[i], name);
        system(buf);
    }
}

void addUserIP(char *ip)
{
    int i;
    int copy = 0;
    for(i = 0; i < count; i++)
    {
        if(strcmp(userIPs[i],ip) == 0)
        {
            copy = 1;
        }
    }
    if(copy == 0)
    {
        userIPs[count] = ip; 
    }
}

void scrubIP(char *ip)
{
    int len = strlen(ip);
    char *newIP = malloc(sizeof(char) * (len-1));
    
    if(ip[len-1] == ' ')
    {
        strncpy(newIP, ip, len-1);
        addUserIP(newIP);
        free(ip);
    }
    else
    {
        addUserIP(ip);
        free(newIP);
    }
}

void addUserID(char *id, char *ip)
{
    int i;
    int copy = 0;
    for(i = 0; i < count; i++)
    {
        if(strcmp(userIDs[i],id) == 0)
        {
            copy = 1;
        }
    }
    if(copy == 0)
    {
        userIDs[count] = id; 
        scrubIP(ip);
    }
    else
    {
        count--;
    }
}

void scrubID(char *id, char *ip)
{
    int len = strlen(id);
    char *newID = malloc(sizeof(char) * (len-1));

    int i;
    int found = 0;
    for(i = len-1; i >= 0; i--)
    {
        if(id[i] == ' ')
        {
            strncpy(newID, (id + i+1), (len - i - 2));
            found = 1;
        }
    }
    if(found == 0)
    {
        strncpy(newID, id, len-1);
    }
    
    addUserID(newID, ip);
    free(id);
} 

void getUserID(char *line)
{
    char *search =  strstr(line, "172.");
    char *ip = malloc(13 * sizeof(char));
    char *id = malloc(31 * sizeof(char));

    int i = 0;
    if(search != NULL)
    {
        strncpy(ip, search, 12);
        strncpy(id, line + 80, 30);
        scrubID(id, ip);
        count++;
    }
}

int main()
{
    //    system("sudo grep 'DHCPACK(wlan0)' /var/log/dnsmasq.log");
    FILE *fp;
    char *grep_output = malloc(1024 * sizeof(char));
    fp = popen("/bin/grep DHCPACK /var/log/dnsmasq.log", "r");
    if(fp == NULL)
    {
        printf("Failed to run command");
        exit(1);
    }
    
    while(fgets(grep_output, 110, fp) != NULL)
    {
        getUserID(grep_output);
    }
    pclose(fp);
    free(grep_output);
   
    printUsers();
    getUsersData();
    freeUsers();

    return 0;
}
