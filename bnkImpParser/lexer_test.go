package bnkImpParser

import (
	"fmt"
	"testing"
)

func TestNextToken(t *testing.T) {
	input := `() ПОДОБНО НЕ РАВНО И ИЛИ ВРЕГ НРЕГ "строка"`
	tests := []struct {
		expectedType    TokenType
		expectedLiteral string
	}{
		{TK_LPAREN, "("},
		{TK_RPAREN, ")"},
		{TK_LIKE, "ПОДОБНО"},
		{TK_NOT, "НЕ"},
		{TK_EQUAL, "РАВНО"},
		{TK_AND, "И"},
		{TK_OR, "ИЛИ"},
		{TK_UPPER_CASE, "ВРЕГ"},
		{TK_LOWER_CASE, "НРЕГ"},
		{TK_STRING, "строка"},
	}
	l := NewLexer(input)
	for i, tt := range tests {
		tok := l.NextToken()
		if tok.Type != tt.expectedType {
			t.Fatalf("tests[%d] - tokentype wrong. expected=%d, got=%d",
				i, tt.expectedType, tok.Type)
		}
		if tok.Literal != tt.expectedLiteral {
			t.Fatalf("tests[%d] - literal wrong. expected=%q, got=%q",
				i, tt.expectedLiteral, tok.Literal)
		}
	}
}

func TestIlligal(t *testing.T) {
	input := `"%aa" ПОДОБНО "%bb" И a2 НЕ РАВНО строка"`

	l := NewLexer(input)
	for {
		tok := l.NextToken()
		if tok.Type == TK_ILLEGAL {
			t.Fatalf("illigal token: %s", tok.Literal)
		}
		fmt.Println("tok=", tok)
	}
}
