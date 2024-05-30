package bnkImpParser

type TokenType int

type Token struct {
	Type    TokenType
	Literal string
}

var keywords = map[string]TokenType{
	"ПОДОБНО": TK_LIKE,
	"РАВНО":   TK_EQUAL,
	"НЕ":      TK_NOT,
	"И":       TK_AND,
	"ИЛИ":     TK_OR,
	"ВРЕГ":    TK_UPPER_CASE,
	"НРЕГ":    TK_LOWER_CASE,
}

const (
	TK_ILLEGAL = iota
	TK_EOF
	TK_LPAREN
	TK_RPAREN
	TK_LIKE
	TK_NOT
	TK_EQUAL
	TK_AND
	TK_OR
	TK_LOWER_CASE
	TK_UPPER_CASE
	TK_STRING
)

func newToken(tokenType TokenType, ch rune) Token {
	return Token{Type: tokenType, Literal: string(ch)}
}
