#include <string.h>
#include <stdlib.h> 
#include <stdio.h> 

#include "analyse_syntaxique.h"
#include "ast_construction.h"
#include "ast_parcours.h"
#include "table_symbole.h"
#include "type_ast.h"

Couple TS[NBMAXSYMB];
int NbSymb;
int c = 1; //condition pour pas executer inst avant appel a interpreter_si_alors_sinon()


void Rec_pgm(Ast *resultat) {
    Rec_seq_inst(resultat);
}

void type_cond(TypeCond *cond){
    char *lexeme = lexeme_courant().chaine; 

    if (strcmp(lexeme, "<=") == 0) {
        *cond = N_INFEGAL;
    } else if (strcmp(lexeme, ">=") == 0) {
        *cond = N_SUPEGAL;
    } else if (strcmp(lexeme, "==") == 0) {
        *cond = N_EGAL;
    } else if (strcmp(lexeme, "!=") == 0) {
        *cond = N_DIFF;
    } else if (strcmp(lexeme, "<<") == 0) {
        *cond = N_INF;
    } else if (strcmp(lexeme, ">>") == 0) {
        *cond = N_SUP;
    } else {
        printf("Erreur type de condition\n");
        exit(1);
    }
}

void Rec_condition(Ast *Acond) {
    Ast Ag,Ad;
    TypeCond cond;
    Rec_eag(&Ag);
    if (lexeme_courant().nature == OPCOMP) {
        //printf("condition = %s\n",lexeme_courant().chaine);
        type_cond(&cond);
    //printf("Condition = %d\n",cond);
        avancer();
        Rec_eag(&Ad);
        *Acond = creer_cond(cond,Ag,Ad);
    } else {
        printf("Erreur: Opérateur de comparaison manquant\n");
        exit(1);
    }
}
void Rec_seq_inst (Ast *resultat) {
    Ast A1;
    Rec_inst(&A1);
    Rec_suite_seq_inst(A1, resultat);
}

void Rec_suite_seq_inst(Ast donnee, Ast *resultat) {
    Ast A2;
    switch (lexeme_courant().nature) {
    case SEPAFF:
        avancer();
        Rec_seq_inst(&A2);
        *resultat = creer_seqinst(donnee, A2);
        break;
    default:
        *resultat = donnee;
        break;
    }
}

void Rec_inst(Ast *resultat) {
    Ast Ag ,Ad, Acond, Athen, Aelse,Abody,Acond2;
    //printf("lexeme courant nature: %d\n", lexeme_courant().nature);   // pour débugger, à décommenter
    //afficheTS(TS, NbSymb);          // pour débugger
    switch (lexeme_courant().nature) {
        case IDF:
            Ag = creer_idf(lexeme_courant().chaine);
            avancer();
            if (lexeme_courant().nature == AFF) {
                avancer();
                Rec_eag(&Ad);
                *resultat = creer_aff(Ag, Ad);
                if(c==1){
                interpreter_aff(*resultat);
                }
                else{
                    if(estPresentTS2(Ag->ident,TS,NbSymb)==0){          
                    insererTS(Ag->ident,0,TS,&NbSymb);}}
            } else {
                printf("Erreur: Instruction invalide (pas de AFF suivant IDF) ou mot-clé invalide\n");
                exit(1);
            }
            break;
        case LIRE:
            avancer();
            if (lexeme_courant().nature == PARO) {
                avancer();
                if (lexeme_courant().nature == IDF) {
                    Ag = creer_idf(lexeme_courant().chaine);
                    avancer();
                    *resultat = creer_lire(Ag);

                if (lexeme_courant().nature == PARF) {
                    avancer();
                    if(lexeme_courant().nature == SEPAFF){
                        if(c==1){
                            interpreter_lire(*resultat);
                        }
                    } else{
                        printf("Erreur : ';' manquant\n");
                        exit(1);
                    }
                } else {
                    printf("Erreur: Parenthèse fermante manquante\n");
                    exit(1);
                }
                } else {
                    printf("Erreur: Identificateur manquant\n");
                    exit(1);
                }
            } else {
                printf("Erreur: Parenthèse ouvrante manquante\n");
                exit(1);
            }
            break;
        case ECRIRE:
            avancer();
            if (lexeme_courant().nature == PARO) {
                avancer();
                Rec_eag(&Ag);
                *resultat = creer_ecrire(Ag);

                if (lexeme_courant().nature == PARF) {
                    avancer();
                if(lexeme_courant().nature == SEPAFF){
                if(c==1){
                    interpreter_ecrire(*resultat);
                }
                    //avancer();
                }
                else{
                    printf("Erreur : ';' manquant\n");
                    exit(1);
                }
                } else {
                    printf("Erreur: Parenthèse fermante manquante\n");
                    exit(1);
                }
            } else {
                printf("Erreur: Parenthèse ouvrante manquante\n");
                exit(1);
            }
            break;
        case SI:
            avancer();
            Rec_condition(&Acond);

            // printf("c = %d\n",c);
            if (lexeme_courant().nature==ALORS) {
                avancer();
                c--;
                Rec_seq_inst(&Athen);
                if (lexeme_courant().nature==SINON) {
                    avancer();
                    Rec_seq_inst(&Aelse);
                    if (lexeme_courant().nature==FSI) {


                        *resultat = creer_if(Acond, Athen, Aelse);
                        avancer();
                        if(lexeme_courant().nature != SEPAFF){
                            interpreter_si_alors_sinon(*resultat);
                            c=1;
                        }

                        }
                    else
                    {
                        printf("Erreur: FSI manquant\n");
                        exit(1);
                    }
                } else {
                    printf("Erreur: SINON manquant\n");
                    exit(1);
                }
            } else {
                printf("Erreur: ALORS manquant\n");
                exit(1); 
            }
            break;
        case TANQUE:
            avancer();
            Rec_condition(&Acond2);
            //c = valeur_booleenne(Acond2);
            if(lexeme_courant().nature == FAIRE){
                avancer();
                c=0;
                Rec_seq_inst(&Abody);
                if(lexeme_courant().nature == FAIT){
                    avancer();
                    //printf("avant\n");
                    //afficheTS(TS,NbSymb);

                    if(lexeme_courant().nature== SEPAFF ){
                        *resultat = creer_while(Acond2,Abody);
                        interpreter_while(*resultat);
                        c=1;
                        avancer();
                    }
                    else{
                        printf("Erreur : ';' manquant\n");
                        exit(1);
                    }
                }
                else{
                    printf("Erreur : FAIT manquant\n");
                    exit(1);
                }
            }
            else{
                printf("Erreur : FAIRE manquant\n");
                exit(1);
            }
            
        default:
            //printf("Erreur: Instruction invalide (rec_inst)\n");
            //exit(1);
            break;
    }
}
void Rec_facteur(Ast *resultat) {
    int v;
    int trouve;              // pour savoir si l'IDF est présent dans la TS
    switch (lexeme_courant().nature) {
    case ENTIER:
        *resultat = creer_valeur(lexeme_courant().valeur,lexeme_courant().chaine);
        avancer();
        /*if(lexeme_courant().nature == ENTIER){
            printf("erreur syntaxique\n");
            exit(1);
        } */
        break;
    case PARO:
        avancer();
        Rec_eag(resultat);
        if (lexeme_courant().nature == PARF) {
            avancer();
        } else {
            printf("Erreur: Parenthèse fermante manquante\n");
            exit(1);
        }
        break;
    case MOINS:
        avancer();
        Ast A1;
        Rec_facteur(&A1);
        *resultat = creer_op_unaire(U_MOINS,A1);
        break;
    case IDF:
        //printf("lexeme courant: %s\n", lexeme_courant().chaine);
        //printf("lexeme courant nature: %d\n", lexeme_courant().nature);
        //afficheTS(TS, NbSymb);
        trouve = estPresentTS(lexeme_courant().chaine, &v, TS, NbSymb);
        if (trouve==1) {
            *resultat = creer_valeur(v,lexeme_courant().chaine);
        } else {
            printf("erreur variable n'est pas définie\n");
            exit(1 );
        }                                       // à décommenter
        avancer();
        break;
    default:
        printf("Erreur: Facteur invalide\n");
        exit(1);
        break;
    }
}

void Rec_terme(Ast *resultat)
{
    Rec_seq_facteur(resultat);
}

void Rec_suite_seq_terme(Ast donnee, Ast *resultat) {
    TypeOperateur Op;
    switch (lexeme_courant().nature) {
    case PLUS:
    case MOINS:
        Rec_op1(&Op); 
        Ast Ad;
        Rec_terme(&Ad);
        *resultat = creer_operation(Op, donnee, Ad);
        Rec_suite_seq_terme(*resultat, resultat);
        break;
    default:
        *resultat = donnee;
        break;
    }
}

void Rec_seq_terme(Ast* resultat) {
    Ast A1;
    Rec_terme(&A1);
    Rec_suite_seq_terme(A1, resultat);
}

void Rec_eag(Ast *resultat)
{
    Rec_seq_terme(resultat);
}


void Rec_suite_seq_facteur(Ast donnee, Ast *resultat) {
    TypeOperateur Op;
    switch (lexeme_courant().nature) {
    case MUL:
    case DIV:
        Rec_op2(&Op);
        Ast Ad;
        Rec_facteur(&Ad);
        *resultat = creer_operation(Op, donnee, Ad);
        Rec_suite_seq_facteur(*resultat, resultat);
        break;
    default:
        *resultat = donnee;
        break;
    }
}


void Rec_seq_facteur(Ast *resultat) {
    Ast A1;
    Rec_facteur(&A1);
    Rec_suite_seq_facteur(A1, resultat);
}


void Rec_op1(TypeOperateur *Op)
{
    switch (lexeme_courant().nature)
    {
    case PLUS:
        *Op = N_PLUS;
        avancer();
        break;
    case MOINS:
       * Op = N_MOINS;
        avancer();
        break;
    default:
        printf("erreur\n");
        exit(0);
        break;
    }
}

void Rec_op2(TypeOperateur *Op)
{
    switch (lexeme_courant().nature)
    {
    case MUL:
        *Op = N_MUL;
        avancer();
        break;
    case DIV:
        *Op = N_DIV;
        avancer();
        break;
    default:
        printf("erreur\n");
        exit(0);
        break;
    }
}

void Rec_aff(Ast *resultat) 
{
    Ast A; 
   // int v;              // valeur de IDF
    char idf[LIDF];     //nom de IDF

    if (lexeme_courant().nature==IDF) {
        strcpy(idf, lexeme_courant().chaine);
        avancer();
        if (lexeme_courant().nature==AFF) {
            avancer();
            Rec_eag(&A);
            //afficher_ast(A);
            interpreter_aff(A);
            if (lexeme_courant().nature==SEPAFF) {
                avancer();
            } else {
                printf("erreur rec aff\n");
                exit(0);
            }
        } else {
            printf("erreur rec aff\n");
            exit(0);
        }
    } else {
        printf("erreur rec aff\n");
        exit(0);
    }
}

void Rec_seq_aff(Ast *resultat)
{
    if (lexeme_courant().nature == AFF) {
        NbSymb = initTS();
        Rec_aff(resultat);
        Rec_seq_aff(resultat);
    } else {
        // cas de epsilon
    }
}

void analyser(char *fichier, Ast *arbre)
{
    demarrer(fichier);   // demarre analyse lexical
    while (! fin_de_sequence())
    {
        Rec_pgm(arbre);
    }  
   //afficheTS(TS, NbSymb);            // pour vérifier tous les affectations dans le tableau, à commenter
    arreter();

}
