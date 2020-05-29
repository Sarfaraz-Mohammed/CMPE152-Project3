grammar compiler_grammar;

statement: assignment_statement
        | if_statement
        | while_statement
        | for_statement
        | do_while_statement
	| printStatement
	| return_statement
	| procedure_call_statement
        ;

compound_statement : (statement)+ ;

assignment_statement: variable '=' expression ';';
return_statement : 'return' expression ';'; 
procedure_call_statement : IDENTIFIER '(' arguments ')' ';'; 

printStatement      : PRINTF '(' formatString printArg* ')' ';' ;
formatString   : STRING ;
printArg       : ',' expression ;

if_statement : IF '(' expression ')' '{' statement '}' (ELSEIF '(' expression ')' '{' statement '}')+ (ELSE '{' statement '}')? ;
while_statement: WHILE '(' expression ')' '{' statement '}';
for_statement: UNTIL '(' expression ')' '{' statement '}';
do_while_statement: DO '{' compound_statement '}' WHILE '(' expression ')' ';' ;

function_call : IDENTIFIER '(' arguments ')'; 

arguments : (expression)*;


//VARIABLES
variable: '&' IDENTIFIER;

expression: expression MULTIPLY expression
        | expression DIVISION expression
        | expression ADDITION expression
        | expression SUBTRACTION expression
        | expression variable
        | expression number
        | '(' expression ')'
        | IDENTIFIER
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

//ARRAYS
ARRAY: 'ARRAY';
NUMBER_ARRAY: 'NUMBER_ARRAY';
CHAR_ARRAY: 'CHAR_ARRAY';



