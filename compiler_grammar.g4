grammar compiler_grammar;

@header {
#include "wci/intermediate/TypeSpec.h"
#include "wci/intermediate/icodeimpl/ICodeImpl.h"
using namespace wci::intermediate;
using namespace wci::intermediate::icodeimpl;
}

program : declarations method_delcarations main_method;
main_method : MAIN '{' (compound_stmt)* (NEWLINE)*'}'; 
declarations: (variable_delcaration)*; 
method_delcarations : (function | procedure)*;

function locals [int locals_var, int stack_var]: IDENTIFIER '(' parameters ')' TYPEID '{' declarations compound_stmt'}' ';' ; 
procedure locals [int locals_var, int stack_var]: IDENTIFIER '(' parameters ')''{' declarations compound_stmt '}' ';' ; 

parameters : (variable_delcaration)*;
variable_delcaration : TYPEID variable ';'; 

stmt : assignment_stmt
	 | if_stmt
	 | while_stmt
	 | until_stmt
	 | do_while_stmt
	 | printStmt
	 | return_stmt
	 | procedure_call_stmt
	 ;

compound_stmt : (stmt)+ ;

assignment_stmt: variable '=' expr ';';
return_stmt : 'return' expression ';'; 
procedure_call_stmt : IDENTIFIER '(' arguments ')' ';'; 

printStatement      : PRINT '(' formatString printArg* ')' ';' ;
formatString   : STRING ;
printArg       : ',' expression ;

if_stmt : IF '(' expr ')' '{' compound_stmt '}' (ELSE_IF '(' expr ')' '{' compound_stmt '}')* (ELSE '{' compound_stmt '}' )? ;
while_stmt: WHILE '(' expr ')' '{' compound_stmt '}';
until_stmt: UNTIL '(' expr ')' '{' compound_stmt '}';
do_while_stmt: DO '{' compound_stmt '}' WHILE '(' expr ')' ';' ;

function_call : IDENTIFIER '(' arguments ')'; 
arguments : (expr)*;


//VARIABLES
variable: '&' IDENTIFIER;

expr: expr MULTIPLY expr
        | expr DIVISION expr
        | expr ADDITION expr
        | expr SUBTRACTION expr
        | variable
        | number
        | '(' expr ')'
        | IDENTIFIER
	| function_call
        ;

//Parser Rules//
//operation: NUMBER '+' NUMBER;

IDENTIFIER: [a-zA-Z][a-zA-Z0-9]*;
INTEGER: [0-9]+;
FLOAT: [0-9]+ '.' [0-9]+;

//IDENTIFIERS
number: sign? INTEGER;
sign: '+' | '-';

//OPERATIONS
MULTIPLY: '*';
DIVISION: '/';
ADDITION: '+';
SUBTRACTION: '-';

//COMPARATIVE OPS
ASSIGN: '=';
LESS_THAN: '<';
LESS_THAN_OR_EQUAL: '<=';
GREATER_THAN: '>';
GREATER_THAN_OR_EQUAL: '>=';
EQUAL: '==';

NEWLINE: '\r'? '\n' -> skip;
WHITESPACE: [\t]+ -> skip;

QUOTE  : '\'' ;
STRING : QUOTE STRING_CHAR* QUOTE ;

fragment STRING_CHAR : QUOTE QUOTE  
                     | ~('\'')      
                     ;

///////-------RESERVED WORDS-------///////
END: 'end';
LENGTH: 'length';
GLOBAL: 'global';
CLOSE: 'close';
RETURN: 'return';
INDEX: 'index';


//LOOPS & CONDITIONALS
WHILE: 'while';
FOR: 'for';
IF: 'if';
ELSEIF: 'elseif';
DO: 'do';
THEN: 'then';
ELSE: 'else';
MAIN : 'main';
TRUE : 'TRUE'; 
FALSE: 'FALSE';

//ARRAYS
ARRAY: 'ARRAY';
NUMBER_ARRAY: 'NUMBER_ARRAY';
CHAR_ARRAY: 'CHAR_ARRAY';



