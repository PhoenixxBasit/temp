#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_RULES 50
#define MAX_LEN 50

// Structure to represent a CFG rule
typedef struct
{
    char lhs[MAX_LEN]; // Left-hand side of the rule
    char rhs[MAX_LEN]; // Right-hand side of the rule
} CFGRule;

// Function to convert CFG to CNF
void convertCFGtoCNF(CFGRule *cfgRules, int numRules)
{
    // CNF rules will be stored in a new array
    CFGRule cnfRules[MAX_RULES * 2];
    int cnfRuleCount = 0;

    for (int i = 0; i < numRules; i++)
    {
        CFGRule rule = cfgRules[i];

        if (strlen(rule.rhs) <= 2)
        {
            // Rule already in CNF
            strcpy(cnfRules[cnfRuleCount].lhs, rule.lhs);
            strcpy(cnfRules[cnfRuleCount].rhs, rule.rhs);
            cnfRuleCount++;
        }
        else
        {
            // Split long RHS into multiple rules
            int len = strlen(rule.rhs);

            while (len > 2)
            {
                CFGRule newRule;
                strncpy(newRule.lhs, rule.rhs, 1);
                newRule.lhs[1] = '\0';

                strncpy(newRule.rhs, rule.rhs + (strlen(rule.rhs) - len + 1), 2);
                newRule.rhs[2] = '\0';

                strcpy(cnfRules[cnfRuleCount].lhs, newRule.lhs);
                strcpy(cnfRules[cnfRuleCount].rhs, newRule.rhs);
                cnfRuleCount++;

                // Update the remaining part of RHS
                strcpy(rule.rhs, newRule.lhs);
                strcat(rule.rhs, newRule.rhs);

                len = strlen(rule.rhs);
            }

            // Add the remaining part of the rule
            strcpy(cnfRules[cnfRuleCount].lhs, rule.lhs);
            strcpy(cnfRules[cnfRuleCount].rhs, rule.rhs);
            cnfRuleCount++;
        }
    }

    // Print the CNF rules
    printf("CNF Rules:\n");
    for (int i = 0; i < cnfRuleCount; i++)
    {
        printf("%s -> %s\n", cnfRules[i].lhs, cnfRules[i].rhs);
    }
}

// Function to convert CNF to CFG
void convertCNFtoCFG(CFGRule *cnfRules, int numRules)
{
    // CFG rules will be stored in a new array
    CFGRule cfgRules[MAX_RULES];
    int cfgRuleCount = 0;

    for (int i = 0; i < numRules; i++)
    {
        CFGRule rule = cnfRules[i];

        if (strlen(rule.rhs) == 1 && rule.rhs[0] >= 'a' && rule.rhs[0] <= 'z')
        {
            // Rule is a terminal, directly copy it to CFG
            strcpy(cfgRules[cfgRuleCount].lhs, rule.lhs);
            strcpy(cfgRules[cfgRuleCount].rhs, rule.rhs);
            cfgRuleCount++;
        }
        else
        {
            // Rule is non-terminal, convert it back to original CFG rule
            int len = strlen(rule.rhs);

            while (len > 2)
            {
                CFGRule newRule;
                strcpy(newRule.lhs, rule.lhs);
                strncpy(newRule.rhs, rule.rhs, 2);
                newRule.rhs[2] = '\0';

                strcpy(cfgRules[cfgRuleCount].lhs, newRule.lhs);
                strcpy(cfgRules[cfgRuleCount].rhs, newRule.rhs);
                cfgRuleCount++;

                // Update the remaining part of RHS
                strcpy(rule.rhs, rule.rhs + 2);

                len = strlen(rule.rhs);
            }

            // Add the remaining part of the rule
            strcpy(cfgRules[cfgRuleCount].lhs, rule.lhs);
            strcpy(cfgRules[cfgRuleCount].rhs, rule.rhs);
            cfgRuleCount++;
        }

        // Print the CFG rules
        printf("CFG Rules:\n");
        for (int i = 0; i < cfgRuleCount; i++)
        {
            printf("%s -> %s\n", cfgRules[i].lhs, cfgRules[i].rhs);
        }
    }
}